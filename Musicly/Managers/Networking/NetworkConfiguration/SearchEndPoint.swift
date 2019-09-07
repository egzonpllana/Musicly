//
//  SearchEndPoint.swift
//  Musicly
//
//  Created by Egzon Pllana on 8/10/19.
//  Copyright © 2019 Native Coders. All rights reserved.
//

import Foundation
import Alamofire

private let lastFMAPIKey: String = "31c33d912968b44595400a2d9f91052f"

enum SearchEndPoint: APIConfiguration {
    case getArtist(name: String)
    case getAlbums(artist: String)
}

extension SearchEndPoint {
    var path: String {
        switch self {
        case .getArtist(let artist): return "method=artist.gettopalbums&artist=\(artist)&api_key=\(lastFMAPIKey)&format=json"
        case .getAlbums(let artist): return "method=artist.gettopalbums&artist=\(artist)&api_key=\(lastFMAPIKey)&format=json"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .getArtist: return .get
        case .getAlbums: return .get
        }
    }

    var parameters: Parameters? {
        switch self {
        case .getArtist, .getAlbums: return nil
        }
    }

}
