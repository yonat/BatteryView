//
//  BatteryShape.swift
//
//  Created by Yonat Sharon on 16/09/2019.
//

#if canImport(SwiftUI)

import SweeterSwift
import SwiftUI

/// Step-by-step progress view with labels and shapes.
@available(iOS 13.0, *) public struct BatteryShape: UIViewRepresentable {
    public typealias UIViewType = BatteryView
    private let uiView = BatteryView()

    @Binding var level: Int

    public init(
        level: Binding<Int>,
        lowThreshold: Int? = nil,
        gradientThreshold: Int? = nil,
        direction: CGRectEdge? = nil,
        isVertical: Bool? = nil,
        terminalLengthRatio: CGFloat? = nil,
        terminalWidthRatio: CGFloat? = nil,
        highLevelColor: UIColor? = nil,
        lowLevelColor: UIColor? = nil,
        noLevelColor: UIColor? = nil,
        noLevelText: String? = nil,
        borderColor: UIColor? = nil,
        borderWidth: CGFloat? = nil,
        cornerRadius: CGFloat? = nil
    ) {
        _level = level
        uiView.translatesAutoresizingMaskIntoConstraints = false
        uiView.lowThreshold =? lowThreshold
        uiView.gradientThreshold =? gradientThreshold
        uiView.direction =? direction
        uiView.isVertical =? isVertical
        uiView.terminalLengthRatio =? terminalLengthRatio
        uiView.terminalWidthRatio =? terminalWidthRatio
        uiView.highLevelColor =? highLevelColor
        uiView.lowLevelColor =? lowLevelColor
        uiView.noLevelColor =? noLevelColor
        uiView.noLevelText =? noLevelText
        uiView.borderColor =? borderColor
        uiView.borderWidth =? borderWidth
        uiView.cornerRadius =? cornerRadius
    }

    public func makeUIView(context: UIViewRepresentableContext<BatteryShape>) -> BatteryView {
        return uiView
    }

    public func updateUIView(_ uiView: BatteryView, context: UIViewRepresentableContext<BatteryShape>) {
        uiView.level = level
    }
}

#endif
