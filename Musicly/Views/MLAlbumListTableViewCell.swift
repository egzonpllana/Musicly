//
//  MLAlbumListTableViewCell.swift
//  Musicly
//
//  Created by Egzon Pllana on 8/17/19.
//  Copyright © 2019 Native Coders. All rights reserved.
//

import UIKit

class MLAlbumListTableViewCell: UITableViewCell, HasDependencies {

    // MARK: - Dependencies
    private lazy var imageLoadingService = dependencies.imageLoaderService()

    // MARK: - Properties

    @IBOutlet weak var gradientView: UIGradientView!
    @IBOutlet weak var playCountLabel: UILabel!
    @IBOutlet weak var albumNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var albumImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.init(white: 1.0, alpha: 0.1)
        selectedBackgroundView = backgroundView
    }

    func populateCell(with album: MLAlbum) {
        playCountLabel.text = "Played: \(album.playcount) times"
        albumNameLabel.text = album.name
        artistNameLabel.text = album.artist.name

        imageLoadingService.load(imagePath: album.images.last?.image, into: albumImage, placeholder: #imageLiteral(resourceName: "profile")) { (result) in
            if case Result.failure(let error) = result {
                assert(false, "image loading error: \(error) for url: \(String(describing: album.images.first?.image))")
            }
        }
    }

}
