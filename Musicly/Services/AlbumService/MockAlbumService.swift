//
//  MockAlbumService.swift
//  Musicly
//
//  Created by Egzon Pllana on 8/10/19.
//  Copyright © 2019 Native Coders. All rights reserved.
//

import Foundation

class MockAlbumService: MockModuleService, AlbumService {

    override init() {
        print("Start of MockAlbumService")
    }

    func searchAlbums(artist: String, completion: @escaping (Result<MLSearch>) -> Void) {
        completion(Result.success(stubSearchData))
    }

    func storeAlbum(_ album: MLAlbum, completion: @escaping (Result<[MLAlbum]>) -> Void) {
        completion(Result.success([stubAlbumData]))
    }

    func deleteAlbum(_ album: MLAlbum, completion: @escaping (Result<[MLAlbum]>) -> Void) {
        completion(Result.success([stubAlbumData]))
    }

    func getStoredAlbums(completion: @escaping (Result<[MLAlbum]>) -> Void) {
        completion(Result.success([stubAlbumData]))
    }
}
