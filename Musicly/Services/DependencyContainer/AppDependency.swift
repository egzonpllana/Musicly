//
//  AppDependency.swift
//  Musicly
//
//  Created by Egzon Pllana on 8/10/19.
//  Copyright © 2019 Native Coders. All rights reserved.
//

import Foundation

class AppDependency: CoreDependency {

    // MARK: - LoaderService
    override func loaderService() -> LoaderService {
        return AppLoaderService()
    }

    // MARK: - StorageService
    override func storageService() -> StorageService {
        return MLRealmStorageService()
    }

    // MARK: - AlbumService
    override func albumService() -> AlbumService {
        let storage = storageService()
        return MLAlbumService(storageService: storage)
    }

    // MARK: - Image Loading Service
    override func imageLoaderService() -> ImageLoaderService {
        return MLImageLoaderService()
    }

    // MARK: - Logger Service
    override func loggerService() -> LoggerService {
        return XCGLoggerService()
    }
}
