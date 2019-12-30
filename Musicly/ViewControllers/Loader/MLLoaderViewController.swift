//
//  MLLoaderViewController.swift
//  Musicly
//
//  Created by Egzon Pllana on 12/30/19.
//  Copyright © 2019 Native Coders. All rights reserved.
//

import UIKit

class MLLoaderViewController: UIViewController, Storyboardable {

    // MARK: - Outlets

    @IBOutlet weak var loaderImageView: UIImageView!

    // MARK: - Storyboardable

    static var storyboardName: String = "Loader"
    let loaderImage = UIImage.animatedImageNamed("loader", duration: 16.0/24.0)

    // MARK: - View life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        loaderImageView.image = loaderImage

        // Do any additional setup after loading the view.
    }
}
