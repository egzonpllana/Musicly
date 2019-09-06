//
//  MLArtist+Realm.swift
//  Musicly
//
//  Created by Egzon Pllana on 8/17/19.
//  Copyright © 2019 Native Coders. All rights reserved.
//

import RealmSwift

@objcMembers
public final class MLArtistObject: Object {
    dynamic var name: String = ""

    override public static func primaryKey() -> String? {
        return MLArtist.primaryKey
    }
}

extension MLArtist: Persistable {
    public init(managedObject: MLArtistObject) {
        name = managedObject.name
    }

    public func managedObject() -> MLArtistObject {
        let artist = MLArtistObject()
        artist.name = name
        return artist
    }
}
