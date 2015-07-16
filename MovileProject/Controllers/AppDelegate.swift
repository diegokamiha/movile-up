//
//  AppDelegate.swift
//  MovileProject
//
//  Created by iOS on 7/15/15
//  Copyright (c) 2015 . All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
        let appearance = UINavigationBar.appearance()
        appearance.barTintColor = .orangeColor()
        
        let attrs = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        appearance.titleTextAttributes = attrs
        appearance.tintColor = .whiteColor()
        return true
    }
}
