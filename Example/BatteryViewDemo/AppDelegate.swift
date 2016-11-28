//
//  AppDelegate.swift
//  BatteryViewDemo
//
//  Created by Yonat Sharon on 28.11.2016.
//  Copyright © 2016 Yonat Sharon. All rights reserved.
//

import UIKit

class BatteryViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let bigBattery = BatteryView(frame: view.bounds.insetBy(dx: 60, dy: 120))
        view.addSubview(bigBattery)

        let littleBattery = BatteryView(frame: CGRect(x: 50, y: 30, width: 25, height: 45))
        littleBattery.lowThreshold = 20
        view.addSubview(littleBattery)

        let horizontalBettery = BatteryView(frame: CGRect(x: 140, y: 30, width: 140, height: 60))
        horizontalBettery.direction = .minXEdge
        horizontalBettery.lowThreshold = 30
        horizontalBettery.borderWidth = 3
        horizontalBettery.highLevelColor = .purple
        horizontalBettery.lowLevelColor = .magenta
        horizontalBettery.backgroundColor = .cyan
        horizontalBettery.cornerRadius = 10
        view.addSubview(horizontalBettery)

        for i in 0...10 {
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(i)) {
                [bigBattery, littleBattery, horizontalBettery].forEach {$0.level = 100 - 10 * i}
            }
        }
    }
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

