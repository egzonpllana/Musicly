//
//  MLSearchAlbumTableViewController.swift
//  Musicly
//
//  Created by Egzon Pllana on 8/17/19.
//  Copyright © 2019 Native Coders. All rights reserved.
//

import UIKit

class MLSearchAlbumTableViewController: UITableViewController, UITextFieldDelegate, HasDependencies {

    // MARK: - Dependencies

    private lazy var albumService: AlbumService = dependencies.albumService()

    // MARK: - Properties

    @IBOutlet weak var searchAlbumTextField: UITextField!
    @IBOutlet weak var footerViewTextLabel: UILabel!

    private var state = DataSourceState<MLAlbum>.loading {
        didSet {
            tableView.reloadData()
        }
    }

    // MARK: - View life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Show search textfield
        searchAlbumTextField.becomeFirstResponder()
    }

    // MARK: - Methods

    private func searchArtist(with artistName: String) {
        albumService.searchAlbums(artist: artistName) { (result) in
            if case Result.success(let searchResults) = result {
                guard !searchResults.topalbums.album.isEmpty else {
                    self.state = .empty
                    self.footerViewTextLabel.text = "No albums found."
                    return
                }
                self.state = .populated(searchResults.topalbums.album)
                self.footerViewTextLabel.text = ""
            }
        }
    }

    // MARK: - Actions

    @IBAction func backButtonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func searchTextFieldValueChanged(_ sender: Any) {
        if let textField = sender as? UITextField, let searchText = textField.text, !searchText.isEmpty {
            searchArtist(with: searchText)
        }
    }

    @IBAction func searchTextFieldPrimaryKey(_ sender: Any) {
        searchAlbumTextField.resignFirstResponder()
    }

}

// MARK: - Navigation

extension MLSearchAlbumTableViewController: SegueHandlerType {
    enum SegueIdentifier: String {
        case albumDetails
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segueIdentifier(for: segue) {
        case .albumDetails:
            if let destination = segue.destination as? MLAlbumDetailsTableViewController, let album = sender as? MLAlbum {
                destination.album = album
            }
        }
    }
}

// MARK: - Table view data source

extension MLSearchAlbumTableViewController {

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return state.currentItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let albumCell: MLAlbumSearchTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        albumCell.populateCell(album: state.currentItems[indexPath.row])
        return albumCell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedAlbum = state.currentItems[indexPath.row]
        self.performSegue(withIdentifier: .albumDetails, sender: selectedAlbum)
    }
}
