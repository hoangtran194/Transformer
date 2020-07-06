//
//  AppDelegate.swift
//  Transformer
//
//  Created by Hoang Tran on 2020-07-02.
//  Copyright © 2020 Hoang Tran. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        UINavigationBar.appearance().barTintColor = UIColor(red:0.08, green:0.23, blue:0.62, alpha:1.0)

        if #available(iOS 13.0, *) {
            // In iOS 13 setup is done in SceneDelegate
        } else {
            let window = UIWindow(frame: UIScreen.main.bounds)
            self.window = window

                let mainstoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewcontroller:UIViewController = mainstoryboard.instantiateViewController(withIdentifier: "HomeTabbarController")
                window.rootViewController = newViewcontroller
        }

        return true
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        if #available(iOS 13.0, *) {
            // In iOS 13 setup is done in SceneDelegate
        } else {
            self.window?.makeKeyAndVisible()
        }
//        UITabBar.appearance().tintColor = UIColor.red
        
//        let selectedColor   = UIColor(red: 246.0/255.0, green: 155.0/255.0, blue: 13.0/255.0, alpha: 1.0)
//        let unselectedColor = UIColor(red: 16.0/255.0, green: 224.0/255.0, blue: 223.0/255.0, alpha: 1.0)
//        
//        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: unselectedColor], for: .normal)
//        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: selectedColor], for: .selected)


        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Not called under iOS 13 - See SceneDelegate sceneWillResignActive
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Not called under iOS 13 - See SceneDelegate sceneDidEnterBackground
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Not called under iOS 13 - See SceneDelegate sceneWillEnterForeground
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Not called under iOS 13 - See SceneDelegate sceneDidBecomeActive
    }

    // MARK: UISceneSession Lifecycle

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

