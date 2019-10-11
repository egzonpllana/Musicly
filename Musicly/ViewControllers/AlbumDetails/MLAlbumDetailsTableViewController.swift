//
//  MLAlbumDetailsTableViewController.swift
//  Musicly
//
//  Created by Egzon Pllana on 8/17/19.
//  Copyright © 2019 Native Coders. All rights reserved.
//

import UIKit

class MLAlbumDetailsTableViewController: UITableViewController, HasDependencies {

    // MARK: - Dependencies

    private lazy var albumService: AlbumService = dependencies.albumService()
    private lazy var loaderService: LoaderService = dependencies.loaderService()
    private lazy var imageLoadingService = dependencies.imageLoaderService()

    // MARK: - Properties

    weak var homeViewController: MLHomeTableViewController?

    var album: MLAlbum!
    var albumStored = false

    @IBOutlet weak var albumImage: UIImageView!
    @IBOutlet weak var albumTitleLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var downloadedAlbumImage: UIImageView!
    @IBOutlet weak var downloadedAlbumLabel: UILabel!

    // MARK: - View life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // load ui with proper data
        loadUI()
    }

    // MARK: - Actions

    @IBAction func closeButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    // MARK: - Methods

    private func loadUI() {
        // check if album is stored in Realm
        isAlbumDownloaded()

        // properties
        albumTitleLabel.text = album.name
        artistNameLabel.text = album.artist.name
        imageLoadingService.load(imagePath: album.images.first?.image, into: albumImage, placeholder: nil) { (result) in
            if case Result.failure(let error) = result {
                assert(false, "image loading error: \(error) for url: \(String(describing: self.album.images.last?.image))")
            }
        }
    }

    private func isAlbumDownloaded() {
        albumService.getStoredAlbums { [weak self] (result) in
            guard let self = self else { return }
            if case Result.success(let albums) = result {
                guard !albums.isEmpty else {
                    return
                }
                let filterAlbumName = albums.filter { $0.name == self.album.name }
                let filterArtistName = albums.filter { $0.artist.name == self.album.artist.name }
                self.manageDownloadButton(((filterAlbumName.count > 0) && (filterArtistName.count > 0)))
            }
        }
    }

    private func downloadAlbum(album: MLAlbum) {
        albumService.storeAlbum(album) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success:
                self.manageDownloadButton(true)
            case .failure(let error):
                AppAlert.create(with: "Error", error: error)
            }
        }
    }

    private func deleteAlbum(album: MLAlbum) {
        albumService.deleteAlbum(album) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success:
                self.manageDownloadButton(false)
            case .failure(let error):
                AppAlert.create(with: "Error", error: error)
            }
        }
    }

    private func manageDownloadButton(_ downloaded: Bool) {
        if downloaded {
            downloadedAlbumLabel.text = "Remove this song"
            albumStored = true
        } else {
            downloadedAlbumLabel.text = "Download this song"
            albumStored = false
        }

        tableView.reloadData()
    }
}

// MARK: - Table view data source

extension MLAlbumDetailsTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 4 { // index 4: download button
            if albumStored {
                deleteAlbum(album: album)
            } else {
                downloadAlbum(album: album)
            }
        }
    }
}
