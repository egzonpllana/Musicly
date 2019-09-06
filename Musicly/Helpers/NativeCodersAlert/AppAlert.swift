//
//  AppAlert.swift
//  Musicly
//
//  Created by Egzon Pllana on 8/12/19.
//  Copyright © 2019 Native Coders. All rights reserved.
//

import UIKit

/// This struct allows you to easily create UIAlerts from Error object or custom messages.
///
/// The alert are created on brand new UIWindows so can be called from anywhere in your code not just from a UIViewController.
public struct AppAlert {

    /**
     Create a Apple Alert, can be called from outside a view controller as it's created on a new window
     If no actions are passed in a default one is added
     */
    public static func create(with title: String?, message: String?, actions: [UIAlertAction] = []) {
        if UIWindow.isNewWindowPresented() { return }
        AppAlert.alert(title: title, message: message, actions: actions)
    }

    /**
     Create a Apple Alert, can be called from outside a view controller as it's created on a new window
     Ability to pass on status bar properties such as hidden and style
     If no actions are passed in a default one is added
     */
    public static func create(with title: String?, message: String?, actions: [UIAlertAction] = [], prefersStatusBarHidden: Bool = UIApplication.shared.isStatusBarHidden, statusBarStyle: UIStatusBarStyle = UIApplication.shared.statusBarStyle) {
        if UIWindow.isNewWindowPresented() { return }
        AppAlert.alert(title: title, message: message, actions: actions, prefersStatusBarHidden: prefersStatusBarHidden, statusBarStyle: statusBarStyle)
    }

    /**
     Create a Apple Alert from a Error, can be called from outside a view controller as it's created on a new window
     If no actions are passed in a default one is added
     */
    public static func create(with title: String?, error: Error, actions: [UIAlertAction] = []) {
        let message = error.localizedDescription
        if UIWindow.isNewWindowPresented() { return }
        AppAlert.alert(title: title, message: message, actions: actions)
    }

    /**
     Create a Apple Alert from an Error, can be called from outside a view controller as it's created on a new window
     Ability to pass on status bar properties such as hidden and style
     If no actions are passed in a default one is added
     */
    public static func create(with title: String?, error: Error, actions: [UIAlertAction] = [], prefersStatusBarHidden: Bool = UIApplication.shared.isStatusBarHidden, statusBarStyle: UIStatusBarStyle = UIApplication.shared.statusBarStyle) {
        if UIWindow.isNewWindowPresented() { return }
        let message = error.localizedDescription
        AppAlert.alert(title: title, message: message, actions: actions, prefersStatusBarHidden: prefersStatusBarHidden, statusBarStyle: statusBarStyle)
    }

    fileprivate static func alert(title: String?, message: String?, actions: [UIAlertAction], prefersStatusBarHidden: Bool = UIApplication.shared.isStatusBarHidden, statusBarStyle: UIStatusBarStyle = UIApplication.shared.statusBarStyle) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if actions.isEmpty {
            alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        } else {
            for action in actions {
                alertController.addAction(action)
            }
        }
        AppAlert.showAlert(alert: alertController, prefersStatusBarHidden: prefersStatusBarHidden, statusBarStyle: statusBarStyle)
    }

    fileprivate static func showAlert(alert: UIAlertController, prefersStatusBarHidden: Bool, statusBarStyle: UIStatusBarStyle) {
        let errorWindow = UIWindow.newWindow(prefersStatusBarHidden: prefersStatusBarHidden, statusBarStyle: statusBarStyle)
        errorWindow.rootViewController!.present(alert, animated: true, completion: nil)
    }
}
