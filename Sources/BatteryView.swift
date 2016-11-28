//
//  BatteryView.swift
//  Show a battery oriented toward ''direction', charged ''level'' percent.
//  Turns red when level drops below ''lowThreshold''.
//
//  Created by Yonat Sharon on 6/1/15.
//  Copyright (c) 2015-6 Yonat Sharon. All rights reserved.
//

import UIKit

@IBDesignable
open class BatteryView: UIView {

    // MARK: - Behavior Properties

    /// 0 to 100 percent full, unavailable = -1
    @IBInspectable open var level: Int = -1                     { didSet {layoutLevel()} }

    /// change color when level crosses the threshold
    @IBInspectable open var lowThreshold: Int = 10              { didSet {layoutFillColor()} }

    // MARK: - Appearance Properties

    /// direction of battery terminal
    open var direction: CGRectEdge = .minYEdge   { didSet {setNeedsLayout()} }

    /// simplified direction of battery terminal (for Interface Builder)
    @IBInspectable open var isVertical: Bool {
        get {return direction == .maxYEdge || direction == .minYEdge}
        set {direction = newValue ? .minYEdge : .maxXEdge}
    }

    // relative size of  battery terminal
    @IBInspectable open var terminalLengthRatio: CGFloat = 0.1  { didSet {setNeedsLayout()} }
    @IBInspectable open var terminalWidthRatio:  CGFloat = 0.4  { didSet {setNeedsLayout()} }

    @IBInspectable open var highLevelColor: UIColor = UIColor(red: 0.0, green: 0.9, blue: 0.0, alpha: 1) { didSet {layoutFillColor()} }
    @IBInspectable open var lowLevelColor: UIColor  = UIColor(red: 0.9, green: 0.0, blue: 0.0, alpha: 1) { didSet {layoutFillColor()} }
    @IBInspectable open var noLevelColor: UIColor   = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1) { didSet {layoutFillColor()} }

    /// set as 0 for default borderWidth = length / 20
    @IBInspectable open var borderWidth: CGFloat = 0        { didSet {layoutBattery(); layoutLevel()} }

    /// set as 0 for default cornerRadius = length / 10
    @IBInspectable open var cornerRadius: CGFloat = 0       { didSet {layoutCornerRadius()} }

    // MARK: - Overrides

    override open var backgroundColor: UIColor? { didSet {layoutFillColor()} }

    override public init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }

    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        setUp()
    }

    override open func layoutSubviews() {
        layoutBattery()
        layoutLevel()
    }

    // MARK: - Sublayers

    private var bodyOutline = CALayer()
    private var terminalOutline = CALayer()
    private var terminalOpening = CALayer()
    private var levelFill = CALayer()

    private func setUp() {
        layer.addSublayer(levelFill)
        layer.addSublayer(bodyOutline)
        layer.addSublayer(terminalOutline)
        layer.addSublayer(terminalOpening)
        setNeedsLayout()
    }

    // MARK: - Layout

    private var length: CGFloat {return isVertical ? bounds.height : bounds.width}

    private func layoutBattery() {
        // divide total length into body and terminal
        let terminalLength = terminalLengthRatio * length
        var (terminalFrame, bodyFrame) = bounds.divided(atDistance: terminalLength, from: direction)

        // layout body
        bodyOutline.frame = bodyFrame
        bodyOutline.borderWidth = borderWidth != 0 ? borderWidth : length / 20

        // layout terminal
        let parallelInsetRatio = (1-terminalWidthRatio) / 2
        let perpendicularInset = bodyOutline.borderWidth
        var (dx, dy) = isVertical ? ( parallelInsetRatio * bounds.width, -perpendicularInset ) : ( -perpendicularInset, parallelInsetRatio * bounds.height )
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
        var levelFrame = bodyOutline.frame.insetBy(dx: bodyOutline.borderWidth, dy: bodyOutline.borderWidth)
        if level >= 0 && level <= 100 {
            let levelInset = (isVertical ? levelFrame.height : levelFrame.width) * CGFloat(100-level) / 100
            (_, levelFrame) = levelFrame.divided(atDistance: levelInset, from: direction)
        }
        levelFill.frame = levelFrame.integral
        layoutCornerRadius()
        layoutFillColor()
    }

    private func layoutFillColor() {
        if level >= 0 && level <= 100 {
            levelFill.backgroundColor = (level > lowThreshold ? highLevelColor : lowLevelColor).cgColor
            terminalOpening.backgroundColor = (backgroundColor ?? .white).cgColor
        }
        else {
            levelFill.backgroundColor = noLevelColor.cgColor
            terminalOpening.backgroundColor = noLevelColor.cgColor
        }
    }

    private func layoutCornerRadius() {
        bodyOutline.cornerRadius = cornerRadius != 0 ? cornerRadius : length / 10
        terminalOutline.cornerRadius = bodyOutline.cornerRadius / 2
    }
}
