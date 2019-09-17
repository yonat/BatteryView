//
//  AppDelegate.swift
//  swiftlint:disable numbers_smell
//
//  Created by Yonat Sharon on 28.11.2016.
//  Copyright © 2016 Yonat Sharon. All rights reserved.
//

import UIKit

#if canImport(SwiftUI)
import SwiftUI
#endif

class BatteryViewController: UIViewController {
    @IBOutlet var battery: BatteryView!
    @IBOutlet var showSwiftUIButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        let bigBattery = BatteryView(frame: view.bounds.insetBy(dx: 80, dy: 150).offsetBy(dx: 0, dy: -20))
        bigBattery.gradientThreshold = 50
        view.addSubview(bigBattery)

        let littleBattery = BatteryView(frame: CGRect(x: 50, y: 30, width: 25, height: 45))
        littleBattery.lowThreshold = 20
        littleBattery.gradientThreshold = 80
        littleBattery.borderColor = .orange
        view.addSubview(littleBattery)

        let horizontalBettery = BatteryView(frame: CGRect(x: 140, y: 30, width: 140, height: 60))
        horizontalBettery.direction = .minXEdge
        horizontalBettery.lowThreshold = 30
        horizontalBettery.gradientThreshold = 50
        horizontalBettery.borderWidth = 3
        horizontalBettery.highLevelColor = .purple
        horizontalBettery.lowLevelColor = .magenta
        horizontalBettery.backgroundColor = .cyan
        horizontalBettery.cornerRadius = 10
        view.addSubview(horizontalBettery)

        for i in 0 ... 10 {
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(i)) {
                [bigBattery, littleBattery, horizontalBettery].forEach { $0.level = 100 - 10 * i }
            }
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if #available(iOS 13.0, *) {
            showSwiftUIButton.isHidden = false
            showSwiftUIButton.layer.borderWidth = 1
            showSwiftUIButton.layer.cornerRadius = showSwiftUIButton.frame.height / 2
            showSwiftUIButton.layer.borderColor = view.tintColor.cgColor
        }
    }

    @IBAction func changeBatteryLevel(_ sender: UISlider) {
        battery.level = Int(sender.value.rounded())
    }

    @IBAction func showSwiftUIDemo() {
        #if canImport(SwiftUI)
        if #available(iOS 13.0, *) {
            present(UIHostingController(rootView: BatteryShapeDemo()), animated: true)
        }
        #endif
    }
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
}
