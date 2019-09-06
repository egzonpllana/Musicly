//
//  MLAlbum.swift
//  Musicly
//
//  Created by Egzon Pllana on 8/10/19.
//  Copyright © 2019 Native Coders. All rights reserved.
//

import Foundation

struct MLAlbum: Codable {
    var name: String
    var artist: MLArtist
    var images: [MLImage]
    var playcount: Int

    enum CodingKeys: String, CodingKey {
        case images = "image"
        case name, artist, playcount
    }
}

extension MLAlbum: Keyable {
    public static let primaryKey: String = "name"
}
