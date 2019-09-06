//
//  MLImage.swift
//  Musicly
//
//  Created by Egzon Pllana on 8/10/19.
//  Copyright © 2019 Native Coders. All rights reserved.
//

import Foundation

struct MLImage: Codable {
    var image: String = ""
    var size: String = ""

    enum CodingKeys: String, CodingKey {
        case image = "#text"
        case size
    }
}

extension MLImage: Keyable {
    public static let primaryKey: String = "image"
}
