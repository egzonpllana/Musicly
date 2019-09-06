//
//  MLImageLoaderService.swift
//  Musicly
//
//  Created by Egzon Pllana on 8/10/19.
//  Copyright © 2019 Native Coders. All rights reserved.
//

import Foundation
import Nuke

class MLImageLoaderService: AppModuleService, ImageLoaderService {

    // MARK: - Image Loader Service version

    override var version: UInt { return 1 }

    func load(imagePath: String?, into imageView: UIImageView, placeholder: UIImage?, completion: @escaping (Result<Void>) -> Void) {
        self.loggerService.log("Load image with path: \(String(describing: imagePath)).")

        guard let imagePath = imagePath, let imageURL = URL(string: imagePath) else {
            imageView.image = placeholder
            completion(Result.success(()))
            return
        }

        let imageRequest = ImageRequest(url: imageURL)
        let imageLoadingOptions = ImageLoadingOptions(placeholder: placeholder,
                                          transition: .fadeIn(duration: 0.3),
                                          failureImage: nil, failureImageTransition: nil,
                                          contentModes: .none)
        Nuke.loadImage(with: imageRequest, options: imageLoadingOptions, into: imageView, progress: nil) { (_, error) in
            if let error = error {
                completion(Result.failure(error))
            } else {
                completion(Result.success(()))
            }
        }
    }

}
