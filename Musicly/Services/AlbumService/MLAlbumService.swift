//
//  MLAlbumService.swift
//  Musicly
//
//  Created by Egzon Pllana on 8/10/19.
//  Copyright © 2019 Native Coders. All rights reserved.
//

import Foundation

class MLAlbumService: AppModuleService, AlbumService {

    // MARK: - Album Service version

    override var version: UInt { return 1 }

    // MARK: - Properties

    let storageService: StorageService
    var storedAlbums: [MLAlbum] {
        get {
            self.loggerService.log("[AlbumService] Get stored albums for key: \(MLAlbum.primaryKey)")
            return storageService.getObjects(MLAlbum.self)
        }
        set {
            self.loggerService.log("[AlbumService] Store new album for key: \(MLAlbum.primaryKey)")
            newValue.forEach { (album) in
                self.storageService.add(album)
            }
        }
    }

    // MARK: - Initialization

    init(storageService: StorageService) {
        self.storageService = storageService
    }

    // MARK: - Factories

    func searchAlbums(artist: String, completion: @escaping (Result<MLSearch>) -> Void) {
        APIClient.performRequest(type: MLSearch.self, withRoute: SearchEndPoint.getAlbums(artist: artist), completion: { result in
            switch result {
            case .success(let albums):
                completion(Result.success(albums))
            case .failure(let error):
                completion(Result.failure(error))
            }
        })
    }

    func storeAlbum(_ album: MLAlbum, completion: @escaping (Result<[MLAlbum]>) -> Void) {
        self.storedAlbums.append(album)
        completion(Result.success(self.storedAlbums))
    }

    func deleteAlbum(_ album: MLAlbum, completion: @escaping (Result<[MLAlbum]>) -> Void) {
        storageService.delete(album, cascade: false)
        completion(Result.success(self.storedAlbums))
    }

    func getStoredAlbums(completion: @escaping (Result<[MLAlbum]>) -> Void) {
        completion(Result.success(self.storedAlbums))
    }

}
