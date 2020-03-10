//
//  AppDelegate.swift
//  HW2.13
//
//  Created by Алексей Маслобоев on 10.03.2020.
//  Copyright © 2020 Алексей Маслобоев. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window? = UIWindow(frame: UIScreen.main.bounds)
        //window?.rootViewController = UINavigationController(rootViewController: <#T##UIViewController#>)
        window?.makeKeyAndVisible()
        
        return true
    }

}

