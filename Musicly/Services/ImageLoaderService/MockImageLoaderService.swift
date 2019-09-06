//
//  MockImageLoaderService.swift
//  Musicly
//
//  Created by Egzon Pllana on 8/10/19.
//  Copyright © 2019 Native Coders. All rights reserved.
//

import UIKit

enum MockImageError: String {
    case imageLoadingError = "Image failed to load"
}

extension MockImageError: LocalizedError {
    var errorDescription: String? {
        return self.rawValue
    }
}

class MockImageLoaderService: MockModuleService, ImageLoaderService {

    override init() {
        print("start of MockImageLoaderService")
    }

    deinit {
        print("end of MockImageLoaderService")
    }

    func load(imagePath: String?, into imageView: UIImageView, placeholder: UIImage?, completion: @escaping (Result<Void>) -> Void) {
        if let placeholder = placeholder {
            imageView.image = placeholder
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            imageView.image = UIImage(named: "photo4")
            completion(Result.success(()))
        }
    }
}
