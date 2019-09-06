//
//  MLAlbum+Realm.swift
//  Musicly
//
//  Created by Egzon Pllana on 8/17/19.
//  Copyright © 2019 Native Coders. All rights reserved.
//

import RealmSwift

@objcMembers
public final class MLAlbumObject: Object {
    dynamic var name: String = ""
    dynamic var artist: MLArtist.ManagedObject? = MLArtist(name: "").managedObject()
    dynamic var images: MLImage.ManagedObject? = MLImage(image: "", size: "").managedObject()
    dynamic var playcount: Int = 0

    override public static func primaryKey() -> String? {
        return MLAlbum.primaryKey
    }
}

extension MLAlbum: Persistable {
    public init(managedObject: MLAlbumObject) {
        name = managedObject.name
        artist = MLArtist(managedObject: managedObject.artist!)
        images = [MLImage(managedObject: managedObject.images!)]
        playcount = managedObject.playcount
    }

    public func managedObject() -> MLAlbumObject {
        let album = MLAlbumObject()
        album.name = name
        album.artist = artist.managedObject()
        album.images = images.last?.managedObject() ?? nil
        album.playcount = playcount
        return album
    }
}
