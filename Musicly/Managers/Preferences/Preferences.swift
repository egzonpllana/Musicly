//
//  Preferences.swift
//  Musicly
//
//  Created by Egzon Pllana on 8/12/19.
//  Copyright © 2019 Native Coders. All rights reserved.
//

import Foundation
class Preferences {

    private let defaults = UserDefaults.standard
    private let deleteAnimationKey: String = "Preferences_deleteAlbum_key"

    /**
     **SEEN DELETE ALBUM ANIMATION**
     * Details
     - will retrieve a boolean value indicating whether the user has seen the delete album or not
     */
    var seenDeleteAnimation: Bool {
        get {
            return defaults.bool(forKey: deleteAnimationKey)
        } set {
            defaults.set(newValue, forKey: deleteAnimationKey)
        }
    }
}
