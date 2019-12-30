//
//  AppLoaderService.swift
//  Musicly
//
//  Created by Egzon Pllana on 8/10/19.
//  Copyright © 2019 Native Coders. All rights reserved.
//

import UIKit

class AppLoaderService: AppModuleService, LoaderService {

    // MARK: - App Loader Service version

    override var version: UInt { return 1 }

    private let windowBounds = UIApplication.shared.keyWindow?.bounds ?? UIScreen.main.bounds
    private weak var loaderWindowRootViewController: UIViewController?

    public var isLoading: Bool {
        return loaderWindowRootViewController != nil
    }

    override init() {
        #if DEBUG
        super.init()
        self.loggerService.log("Show loader")
        #endif
    }

    deinit {
        #if DEBUG
        self.loggerService.log("Hide loader")
        #endif
    }

    func showLoadingIndicator() {
        self.loggerService.log("ShowLoadingIndicator()")
        guard !isLoading else {
            #if DEBUG
            print("A loader is already on screen")
            #endif
            return
        }

        /// Init loader view controller
        let loader = MLLoaderViewController.instantiate()
        loader.modalTransitionStyle = .crossDissolve
        loader.modalPresentationStyle = .overCurrentContext

        /// Present loader
        loaderWindowRootViewController = self.topViewController()
        loaderWindowRootViewController?.present(loader, animated: true, completion: nil)

    }

    func hideLoadingIndicator() {
        self.loggerService.log("HideLoadingIndicator()")
        guard isLoading else {
            #if DEBUG
            print("No loader on screen")
            #endif
            return
        }
        loaderWindowRootViewController?.dismiss(animated: true, completion: nil)
        loaderWindowRootViewController = nil
    }
}

private extension AppLoaderService {
    func topViewController(_ viewController: UIViewController? = UIApplication.shared.windows.filter({$0.isKeyWindow}).first?.rootViewController) -> UIViewController? {
        if let nav = viewController as? UINavigationController {
            return topViewController(nav.visibleViewController)
        }
        if let tab = viewController as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(selected)
            }
        }
        if let presented = viewController?.presentedViewController {
            return topViewController(presented)
        }
        return viewController
    }
}
