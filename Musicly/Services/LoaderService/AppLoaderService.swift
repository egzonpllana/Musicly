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

        guard let loader = UIStoryboard(name: .loader).instantiateInitialViewController() else {
            fatalError("Missing initial view controller in \(StoryboardIdentifier.loader) storyboard")
        }
        loader.modalTransitionStyle = .crossDissolve
        let newWindow = UIWindow(frame: windowBounds)
        newWindow.windowLevel = UIWindow.Level.statusBar
        newWindow.rootViewController = UIViewController()
        newWindow.isHidden = false
        loaderWindowRootViewController = newWindow.rootViewController
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

class LoaderViewController: UIViewController {

    @IBOutlet weak var loaderImageView: UIImageView!
    let loaderImage = UIImage.animatedImageNamed("loader", duration: 16.0/24.0)

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        loaderImageView.image = loaderImage
    }
}
