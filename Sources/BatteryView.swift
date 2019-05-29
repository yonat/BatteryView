//
//  BatteryView.swift
//
//  Created by Yonat Sharon on 6/1/15.
//  Copyright (c) 2015-6 Yonat Sharon. All rights reserved.
//

import UIKit

extension Int {
    static let fullBattery = 100
}

/// Show a battery oriented toward `direction`, charged `level` percent.
/// Turns red when level drops below `lowThreshold`, or gradually when below `gradientThreshold`.
@IBDesignable open class BatteryView: UIView {
    // MARK: - Behavior Properties

    /// 0 to 100 percent full, unavailable = -1
    @IBInspectable open var level: Int = -1 { didSet { layoutLevel() } }

    /// change color when level crosses the threshold
    @IBInspectable open dynamic var lowThreshold: Int = 10 { didSet { layoutFillColor() } }

    /// gradually change color when level crosses the threshold
    @IBInspectable open dynamic var gradientThreshold: Int = 0 { didSet { layoutFillColor() } }

    // MARK: - Appearance Properties

    /// direction of battery terminal
    @objc open dynamic var direction: CGRectEdge = .minYEdge { didSet { setNeedsLayout() } }

    /// simplified direction of battery terminal (for Interface Builder)
    @IBInspectable open dynamic var isVertical: Bool {
        get { return direction == .maxYEdge || direction == .minYEdge }
        set { direction = newValue ? .minYEdge : .maxXEdge }
    }

    // relative size of  battery terminal
    @IBInspectable open dynamic var terminalLengthRatio: CGFloat = 0.1 { didSet { setNeedsLayout() } }
    @IBInspectable open dynamic var terminalWidthRatio: CGFloat = 0.4 { didSet { setNeedsLayout() } }

    // swiftlint:disable redundant_type_annotation
    @IBInspectable open dynamic var highLevelColor: UIColor = UIColor(red: 0.0, green: 0.9, blue: 0.0, alpha: 1) { didSet { layoutFillColor() } }
    @IBInspectable open dynamic var lowLevelColor: UIColor = UIColor(red: 0.9, green: 0.0, blue: 0.0, alpha: 1) { didSet { layoutFillColor() } }
    @IBInspectable open dynamic var noLevelColor: UIColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1) { didSet { layoutFillColor() } }
    // swiftlint:enable redundant_type_annotation

    @IBInspectable open dynamic var borderColor: UIColor = .black {
        didSet {
            bodyOutline.borderColor = borderColor.cgColor
            terminalOutline.borderColor = borderColor.cgColor
        }
    }

    /// set as 0 for default borderWidth = length / 20
    @IBInspectable open dynamic var borderWidth: CGFloat = 0 { didSet { layoutBattery(); layoutLevel() } }

    /// set as 0 for default cornerRadius = length / 10
    @IBInspectable open dynamic var cornerRadius: CGFloat = 0 { didSet { layoutCornerRadius() } }

    // MARK: - Overrides

    open override var backgroundColor: UIColor? { didSet { layoutFillColor() } }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUp()
    }

    open override func layoutSubviews() {
        super.layoutSubviews()
        layoutBattery()
        layoutLevel()
    }

    // MARK: - Sublayers

    private var bodyOutline = CALayer()
    private var terminalOutline = CALayer()
    private var terminalOpening = CALayer()
    private var levelFill = CALayer()

    private func setUp() {
        layer.addSublayer(bodyOutline)
        bodyOutline.masksToBounds = true
        bodyOutline.addSublayer(levelFill)
        layer.addSublayer(terminalOutline)
        layer.addSublayer(terminalOpening)
        setNeedsLayout()
    }

    // MARK: - Layout

    private var length: CGFloat { return isVertical ? bounds.height : bounds.width }

    private func layoutBattery() {
        // divide total length into body and terminal
        let terminalLength = terminalLengthRatio * length
        var (terminalFrame, bodyFrame) = bounds.divided(atDistance: terminalLength, from: direction)

        // layout body
        bodyOutline.frame = bodyFrame
        bodyOutline.borderWidth = borderWidth != 0 ? borderWidth : length / 20

        // layout terminal
        let parallelInsetRatio = (1 - terminalWidthRatio) / 2
        let perpendicularInset = bodyOutline.borderWidth
        var (dx, dy) = isVertical
            ? (parallelInsetRatio * bounds.width, -perpendicularInset)
            : (-perpendicularInset, parallelInsetRatio * bounds.height)
        terminalFrame = terminalFrame.insetBy(dx: dx, dy: dy)
        (_, terminalFrame) = terminalFrame.divided(atDistance: perpendicularInset, from: direction)
        terminalOutline.frame = terminalFrame
        terminalOutline.borderWidth = bodyOutline.borderWidth

        // cover terminal opening
        var (_, coverFrame) = terminalFrame.divided(atDistance: perpendicularInset, from: direction)
        (dx, dy) = isVertical ? (perpendicularInset, -0.25) : (-0.25, perpendicularInset)
        coverFrame = coverFrame.insetBy(dx: dx, dy: dy)
        terminalOpening.frame = coverFrame
        terminalOpening.backgroundColor = noLevelColor.cgColor

        // layout empty levelFill
        levelFill.frame = bodyFrame.insetBy(dx: perpendicularInset, dy: perpendicularInset).integral
        levelFill.backgroundColor = noLevelColor.cgColor
    }

    private func layoutLevel() {
        var levelFrame = bodyOutline.bounds.insetBy(dx: bodyOutline.borderWidth, dy: bodyOutline.borderWidth)
        if level >= 0 && level <= .fullBattery {
            let levelInset = (isVertical ? levelFrame.height : levelFrame.width) * CGFloat(.fullBattery - level) / CGFloat(.fullBattery)
            (_, levelFrame) = levelFrame.divided(atDistance: levelInset, from: direction)
        }
        levelFill.frame = levelFrame.integral
        layoutCornerRadius()
        layoutFillColor()
    }

    private func layoutFillColor() {
        if level >= 0 && level <= .fullBattery {
            switch level {
            case 0 ... lowThreshold:
                levelFill.backgroundColor = lowLevelColor.cgColor
            case gradientThreshold ... 100:
                levelFill.backgroundColor = highLevelColor.cgColor
            default:
                let fraction = CGFloat(level - lowThreshold) / CGFloat(min(gradientThreshold, .fullBattery) - lowThreshold)
                levelFill.backgroundColor = lowLevelColor.blend(with: highLevelColor, fraction: fraction).cgColor
            }
            terminalOpening.backgroundColor = (backgroundColor ?? .white).cgColor
        } else {
            levelFill.backgroundColor = noLevelColor.cgColor
            terminalOpening.backgroundColor = noLevelColor.cgColor
        }
    }

    private func layoutCornerRadius() {
        bodyOutline.cornerRadius = cornerRadius != 0 ? cornerRadius : length / 10
        terminalOutline.cornerRadius = bodyOutline.cornerRadius / 2
    }
}

// swiftlint:disable identifier_name
extension UIColor {
    func blend(with otherColor: UIColor, fraction: CGFloat) -> UIColor {
        let f = min(1, max(0, fraction))
        var h1: CGFloat = 0, s1: CGFloat = 0, b1: CGFloat = 0, a1: CGFloat = 0
        getHue(&h1, saturation: &s1, brightness: &b1, alpha: &a1)
        var h2: CGFloat = 0, s2: CGFloat = 0, b2: CGFloat = 0, a2: CGFloat = 0
        otherColor.getHue(&h2, saturation: &s2, brightness: &b2, alpha: &a2)
        let h = h1 + (h2 - h1) * f
        let s = s1 + (s2 - b1) * f
        let b = b1 + (b2 - b1) * f
        let a = a1 + (a2 - a1) * f
        return UIColor(hue: h, saturation: s, brightness: b, alpha: a)
    }
}
