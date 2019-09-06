//
//  MLAlbum+Realm.swift
//  Musicly
//
//  Created by Egzon Pllana on 8/17/19.
//  Copyright © 2019 Native Coders. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers
public final class MLAlbumObject: Object {
    dynamic var name: String = ""
    dynamic var artist: MLArtist = MLArtist(name: "")
    dynamic var image: [MLImage] = [MLImage(image: "", size: "")]
    dynamic var playcount: Int = 0

    override public static func primaryKey() -> String? {
        return MLAlbum.primaryKey
    }
}

extension MLAlbum: Persistable {
    public init(managedObject: MLAlbumObject) {
        name = managedObject.name
        artist = managedObject.artist
        image = managedObject.image
        playcount = managedObject.playcount
    }

    public func managedObject() -> MLAlbumObject {
        let album = MLAlbumObject()
        album.name = name
        album.artist = artist
        album.image = image
        album.playcount = playcount
        return album
    }
}
