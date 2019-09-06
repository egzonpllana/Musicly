//
//  MLImage+Realm.swift
//  Musicly
//
//  Created by Egzon Pllana on 8/17/19.
//  Copyright © 2019 Native Coders. All rights reserved.
//

import RealmSwift

@objcMembers
public final class MLImageObject: Object {
    dynamic var image: String = ""
    dynamic var size: String = ""

    override public static func primaryKey() -> String? {
        return MLImage.primaryKey
    }
}

extension MLImage: Persistable {
    public init(managedObject: MLImageObject) {
        image = managedObject.image
        size = managedObject.size
    }

    public func managedObject() -> MLImageObject {
        let imageObject = MLImageObject()
        imageObject.image = image
        imageObject.size = size
        return imageObject
    }
}
