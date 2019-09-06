//
//  StoryboardIdentifier.swift
//  Musicly
//
//  Created by Egzon Pllana on 8/10/19.
//  Copyright © 2019 Native Coders. All rights reserved.
//

import Foundation
import UIKit

struct StoryboardIdentifier {

    let rawValue: String

    public init(rawValue: String) {
        self.rawValue = rawValue
    }

}

extension StoryboardIdentifier {
    static let loader = StoryboardIdentifier(rawValue: "Loader")
}

extension UIStoryboard {

    convenience init(name: StoryboardIdentifier, bundle storyboardBundleOrNil: Bundle? = nil) {
        self.init(name: name.rawValue, bundle: storyboardBundleOrNil)
    }

}
