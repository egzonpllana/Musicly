//  UIWindow+newWindow.swift
//  Musicly
//
//  Created by Egzon Pllana on 8/12/19.
//  Copyright © 2019 Native Coders. All rights reserved.
//

import UIKit

extension UIWindow {
    static func newWindow(level: UIWindow.Level = UIWindow.Level.statusBar, prefersStatusBarHidden: Bool = UIApplication.shared.isStatusBarHidden, statusBarStyle: UIStatusBarStyle = UIApplication.shared.statusBarStyle) -> UIWindow {
        let windowBounds = UIApplication.shared.keyWindow?.bounds ?? UIScreen.main.bounds
        let window = UIWindow(frame: windowBounds)
        window.windowLevel = level
        window.isHidden = false
        window.rootViewController = NewWindowViewController(prefersStatusBarHidden: prefersStatusBarHidden, statusBarStyle: statusBarStyle)
        return window
    }

    static func isNewWindowPresented(defaultWindowLevel: UIWindow.Level = .normal, defaultNewWindowLevel: UIWindow.Level = UIWindow.Level(rawValue: UIWindow.Level.normal.rawValue + 1)) -> Bool {
        let windowBounds = UIApplication.shared.keyWindow?.bounds ?? UIScreen.main.bounds
        let window = UIWindow(frame: windowBounds)
        if window.windowLevel >= (defaultWindowLevel.rawValue + defaultNewWindowLevel) { return true }
        return false
    }

    fileprivate final class NewWindowViewController: UIViewController {

        private let isStatusBarHidden: Bool
        private let statusBarStyle: UIStatusBarStyle

        init(prefersStatusBarHidden: Bool, statusBarStyle: UIStatusBarStyle) {
            self.isStatusBarHidden = prefersStatusBarHidden
            self.statusBarStyle = statusBarStyle
            super.init(nibName: nil, bundle: nil)
        }

        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        override var prefersStatusBarHidden: Bool {
            return isStatusBarHidden
        }

        override var preferredStatusBarStyle: UIStatusBarStyle {
            return statusBarStyle
        }
    }
}
