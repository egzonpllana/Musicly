//
//  ImageLoaderService.swift
//  Musicly
//
//  Created by Egzon Pllana on 8/10/19.
//  Copyright © 2019 Native Coders. All rights reserved.
//

import UIKit

enum ImageLoaderServiceError: String {
    case imageNotFound = "Image not found"
}

extension ImageLoaderServiceError: LocalizedError {
    var errorDescription: String? {
        return self.rawValue
    }
}

protocol ImageLoaderService {

    /**
     **LOAD IMAGE**
     * Details:
     - takes a image URL, imageView and placeholder. Specify what type of image you would like to display while the image loads.
     - load method also handles caching of image
     - Parameters:
     - imagePath: The URL String for the image
     - imageView: the image view you wish to load the image into
     - placeholder: the image you want to display while the image loads. specify nil if you don't want to display a placeholder
     - completion: Result object with associated type Void
     */
    func load(imagePath: String?, into imageView: UIImageView, placeholder: UIImage?, completion: @escaping (Result<Void>) -> Void)
}
