//
//  MLAlbumSearchTableViewCell.swift
//  Musicly
//
//  Created by Egzon Pllana on 8/17/19.
//  Copyright © 2019 Native Coders. All rights reserved.
//

import UIKit

class MLAlbumSearchTableViewCell: UITableViewCell, HasDependencies {

    // MARK: - Dependencies
    private lazy var imageLoadingService = dependencies.imageLoaderService()

    // MARK: - Properties

    @IBOutlet weak var albumNameLabel: UILabel!
    @IBOutlet weak var albumArtistLabel: UILabel!
    @IBOutlet weak var albumImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.init(white: 1.0, alpha: 0.1)
        selectedBackgroundView = backgroundView
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func populateCell(album: MLAlbum) {
        albumNameLabel.text = album.name
        albumArtistLabel.text = album.artist.name

        imageLoadingService.load(imagePath: album.images.first?.image, into: albumImage, placeholder: #imageLiteral(resourceName: "profile")) { (result) in
            if case Result.failure(let error) = result {
                assert(false, "image loading error: \(error) for url: \(String(describing: album.images.first?.image))")
            }
        }
    }

}
