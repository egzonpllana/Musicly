//
//  DataSourceState.swift
//  Musicly
//
//  Created by Egzon Pllana on 9/4/19.
//  Copyright © 2019 Native Coders. All rights reserved.
//

import Foundation

enum DataSourceState<T> {
    case loading
    case populated([T])
    case empty
    case error(Error)

    var currentItems: [T] {
        switch self {
        case .populated(let items): return items
        default: return []
        }
    }
}
