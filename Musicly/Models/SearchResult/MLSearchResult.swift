//
//  MLSearchResult.swift
//  Musicly
//
//  Created by Egzon Pllana on 8/17/19.
//  Copyright © 2019 Native Coders. All rights reserved.
//

import Foundation

struct MLSearch: Codable {
    var topalbums: SearchResult
}

struct SearchResult: Codable {
    var album: [MLAlbum]
}
