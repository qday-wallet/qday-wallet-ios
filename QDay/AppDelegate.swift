//
//  AppDelegate.swift
//  NBWallet
//
//  Created by Qiyeyun2 on 2024/7/15.
//

import UIKit
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        IQKeyboardManager.shared.enable = true
        self.window?.frame = UIScreen.main.bounds;
        let vc = HomeViewController();
        let nav = NavigationController(rootViewController: vc);
        self.window?.rootViewController = nav;
        self.window?.makeKeyAndVisible();
        return true
    }


}

