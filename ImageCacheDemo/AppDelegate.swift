//
//  AppDelegate.swift
//  ImageCacheDemo
//
//  Created by Abhinay on 02/08/18.
//  Copyright © 2018 ONS. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool
    {
        
        ApplicationAppearence.initialAppearance()
        
        window = UIWindow(frame:UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        let homeVC = HomeVC()
        let navVC = UINavigationController(rootViewController:homeVC)
        window?.rootViewController = navVC
        
        return true
    }


}

