//
//  MLHomeTableViewController.swift
//  Musicly
//
//  Created by Egzon Pllana on 8/17/19.
//  Copyright © 2019 Native Coders. All rights reserved.
//

import UIKit

class MLHomeTableViewController: UITableViewController, HasDependencies {

    // MARK: - Dependencies

    private lazy var albumService: AlbumService = dependencies.albumService()

    // MARK: - Properties

    @IBOutlet weak var emptyBackgroundView: UIView!
    @IBOutlet weak var emptyViewTitleLabel: UILabel!
    @IBOutlet weak var emptyViewDescriptionLabel: UILabel!

    private var state = DataSourceState<MLAlbum>.loading {
        didSet {
            setFooterView()
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setFooterView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadAlbums()
    }

    func loadAlbums() {
        albumService.getStoredAlbums { (result) in
            switch result {
            case .success(let albums):
                guard !albums.isEmpty else {
                    self.state = .empty
                    return
                }
                self.state = .populated(albums)
            case .failure(let error):
                self.state = .error(error)
            }
        }
    }

    private func setFooterView() {
        switch state {
        case .error(let error):
            emptyViewTitleLabel.text = "Error"
            emptyViewDescriptionLabel.text = error.localizedDescription
            tableView.tableFooterView = emptyBackgroundView
        case .empty, .loading: /* Default state configured in storyboard */
            tableView.tableFooterView = emptyBackgroundView
        case .populated:
            tableView.tableFooterView = nil
        }
    }

    @IBAction func unwindToHomeScreen(_ segue: UIStoryboardSegue) { }
}

// MARK: - Table view data source

extension MLHomeTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return state.currentItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let albumCell: MLAlbumListTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        albumCell.populateCell(with: state.currentItems[indexPath.row])
        return albumCell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedAlbum = state.currentItems[indexPath.row]
        self.performSegue(withIdentifier: .albumDetails, sender: selectedAlbum)
    }
}

// MARK: - Navigation

extension MLHomeTableViewController: SegueHandlerType {
    enum SegueIdentifier: String {
        case albumDetails
        case searchAlbum
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segueIdentifier(for: segue) {
        case .albumDetails:
            if let destination = segue.destination as? MLAlbumDetailsTableViewController, let album = sender as? MLAlbum {
                destination.album = album
            }
        case .searchAlbum:
            break
        }
    }
}
