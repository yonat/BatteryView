//
//  BatteryShapeDemo.swift
//
//  Copyright © 2019 Yonat Sharon. All rights reserved.
//

// swiftlint:disable numbers_smell

#if canImport(SwiftUI)

import SwiftUI

@available(iOS 13.0, *)
struct BatteryShapeDemo: View {
    @State private var level: Double = -1

    var body: some View {
        VStack(spacing: 32) {
            Spacer()
            HStack(spacing: 32) {
                BatteryShape(level: $level.int, noLevelText: "")
                    .aspectRatio(0.5, contentMode: .fit)
                BatteryShape(level: $level.int, gradientThreshold: 100, borderColor: .brown)
                    .aspectRatio(0.75, contentMode: .fit)
            }
                .frame(height: 150)
            BatteryShape(level: $level.int, isVertical: false, noLevelText: "🤷🏼‍♂️")
                .aspectRatio(2, contentMode: .fit)
                .frame(height: 80)
            BatteryShape(
                level: $level.int,
                gradientThreshold: 100,
                direction: .minXEdge,
                highLevelColor: .blue,
                lowLevelColor: .orange,
                noLevelColor: .systemBackground,
                noLevelText: "",
                borderColor: .cyan,
                borderWidth: 3,
                cornerRadius: 6
            )
                .aspectRatio(3, contentMode: .fit)
                .frame(height: 80)
            Spacer()
            VStack {
                Text("Change Battery Level:").bold()
                Slider(value: $level, in: 0.0 ... 100.0, step: 1.0)
            }
            Spacer()
            Button(action: { self.level = -1 }, label: { Text("Clear Battery Level").bold() })
            Spacer()
        }
        .padding()
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                if self.level != -1 { return }
                withAnimation { self.level = 100 }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    withAnimation { self.level = 50 }
                }
            }
        }
    }
}

private extension Double {
    var int: Int {
        get { Int(self) }
        set { self = Double(newValue) }
    }
}

#endif
