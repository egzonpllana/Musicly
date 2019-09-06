//
//  MLStubData.swift
//  Musicly
//
//  Created by Egzon Pllana on 8/12/19.
//  Copyright © 2019 Native Coders. All rights reserved.
//

import Foundation

let stubImageData = MLImage(image: "https://ritaora.com/wp-content/themes/ritaora/images/only_want_you.jpg", size: "small")

let stubArtistData = MLArtist(name: "Rita Ora")

let stubPlayCount = Int(arc4random())

let stubAlbumData = MLAlbum(name: "Phoenix", artist: stubArtistData, images: [stubImageData], playcount: stubPlayCount)

let stubSearchResult = SearchResult(album: [stubAlbumData])

let stubSearchData = MLSearch(topalbums: stubSearchResult)
