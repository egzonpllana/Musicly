//
//  SegueHandlerType.swift
//  Musicly
//
//  Created by Egzon Pllana on 8/12/19.
//  Copyright © 2019 Native Coders. All rights reserved.
//

// NOTE: Our Segue Handler Type system is based on
// https://www.natashatherobot.com/protocol-oriented-segue-identifiers-swift/

import UIKit

/// Use in view controllers:
///
/// 1) Have view controller conform to SegueHandlerType
/// 2) Add `enum SegueIdentifier: String { }` to conformance
/// 3) Manual segues are trigged by `performSegue(with:sender:)`
/// 4) `prepare(for:sender:)` does a `switch segueIdentifier(for: segue)` to select the appropriate segue case

public protocol SegueHandlerType {
    associatedtype SegueIdentifier: RawRepresentable
}

public extension SegueHandlerType where Self: UIViewController, SegueIdentifier.RawValue == String {

    func performSegue(withIdentifier identifier: SegueIdentifier, sender: Any?) {
        performSegue(withIdentifier: identifier.rawValue, sender: sender)
    }

    func segueIdentifier(for segue: UIStoryboardSegue) -> SegueIdentifier {
        guard
            let identifier = segue.identifier,
            let segueIdentifier = SegueIdentifier(rawValue: identifier)
            else {
                fatalError(String(format: "Receiver (%@) has no segue with identifier '%@'", arguments: [ self, segue.identifier ?? "" ]))
        }

        return segueIdentifier
    }

}
