//
//  AlbumService.swift
//  Musicly
//
//  Created by Egzon Pllana on 8/10/19.
//  Copyright © 2019 Native Coders. All rights reserved.
//

import Foundation

protocol AlbumService {
    /*
     **GET ALBUMS**
     * Details:
     - Get a list of albums from API
     - Parameters:
     - Parameters: name of artist
     - Completion: Result array of MLSearch
     */
    func searchAlbums(artist: String, completion: @escaping (Result<MLSearch>) -> Void)

    /*
     **STORE ALBUM**
     * Details:
     - Store an album
     - Parameters: MLAlbum
     - Completion: Result with array of MLAlbum
     */
    func storeAlbum(_ album: MLAlbum, completion: @escaping (Result<[MLAlbum]>) -> Void)

    /*
     **REMOVE ALBUM**
     * Details:
     - Remove an album
     - Parameters: MLAlbum
     - Completion: Result with array of MLAlbum
     */
    func deleteAlbum(_ album: MLAlbum, completion: @escaping (Result<[MLAlbum]>) -> Void)

    /*
     **GET STORED ALBUMS**
     * Details:
     - Get list of stored albums in Realm
     - No parameters needed
     - Completion: Result array of MLAlbum
     */
    func getStoredAlbums(completion: @escaping (Result<[MLAlbum]>) -> Void)
}
