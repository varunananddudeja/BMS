//
//  AppDelegate.swift
//  BMS
//
//  Created by Varun Dudeja on 12/04/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = RootWireframe().viewController
        window?.makeKeyAndVisible()
        return true
    }
}

