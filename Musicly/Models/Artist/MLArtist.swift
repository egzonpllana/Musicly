//
//  MLArtist.swift
//  Musicly
//
//  Created by Egzon Pllana on 8/10/19.
//  Copyright © 2019 Native Coders. All rights reserved.
//

import Foundation

struct MLArtist: Codable {
    var name: String = ""
}

extension MLArtist: Keyable {
    public static let primaryKey: String = "name"
}
