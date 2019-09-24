//
//  AppDelegate.swift
//  Musicly
//
//  Created by Egzon Pllana on 8/10/19.
//  Copyright © 2019 Native Coders. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, HasDependencies {

    var window: UIWindow?

    private lazy var loggerService: LoggerService = dependencies.loggerService()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        // Initialization of AppDependency
        configure(dependency: AppDependency())

        // Log options for didFinishLaunching
        self.loggerService.log("Application did finish launching with \(String(describing: launchOptions)) in \(application.applicationState)", level: .info)

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
        self.loggerService.log("Application will resign active", level: .info)
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        self.loggerService.log("Application did enter background", level: .info)
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        UIApplication.shared.applicationIconBadgeNumber = 0
        self.loggerService.log("Application will enter foreground", level: .info)
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        self.loggerService.log("Application did become active", level: .info)
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        self.loggerService.log("Application will terminate", level: .info)
    }
}
