//
//  LoaderService.swift
//  Musicly
//
//  Created by Egzon Pllana on 8/10/19.
//  Copyright © 2019 Native Coders. All rights reserved.
//

import Foundation

protocol LoaderService: ModuleService {
    var isLoading: Bool { get }
    func showLoadingIndicator()
    func hideLoadingIndicator()
}
