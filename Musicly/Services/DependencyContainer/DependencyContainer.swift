//
//  Dependency.swift
//  Musicly
//
//  Created by Egzon Pllana on 8/10/19.
//  Copyright © 2019 Native Coders. All rights reserved.
//

// NOTE: Our Dependency Injection system is based on
// http://basememara.com/swift-protocol-oriented-dependency-injection/

import Foundation
import UIKit

// List all services that the app will use
protocol Dependency {
    func loaderService() -> LoaderService
    func storageService() -> StorageService
    func albumService() -> AlbumService
    func imageLoaderService() -> ImageLoaderService
    func loggerService() -> LoggerService
}

class CoreDependency: Dependency {

    func loaderService() -> LoaderService {
        return MockLoaderService()
    }

    func storageService() -> StorageService {
        return MockStorageService()
    }

    func albumService() -> AlbumService {
        return MockAlbumService()
    }

    func imageLoaderService() -> ImageLoaderService {
        return MockImageLoaderService()
    }

    func loggerService() -> LoggerService {
        return MockLoggerService()
    }
}

/// The singleton dependency container reference
/// which can be reassigned to another container
struct DependencyInjector {
    static var dependencies: Dependency = CoreDependency()
    private init() { }
}

/// Attach to any type for exposing the dependency container
protocol HasDependencies {
    var dependencies: Dependency { get }
}

extension HasDependencies {
    /// container for dependency instance factories
    var dependencies: Dependency {
        return DependencyInjector.dependencies
    }
}

extension UIApplicationDelegate {
    func configure(dependency: Dependency) {
        DependencyInjector.dependencies = dependency
    }
}
