//
//  MockLoaderService.swift
//  Musicly
//
//  Created by Egzon Pllana on 8/10/19.
//  Copyright © 2019 Native Coders. All rights reserved.
//

import Foundation

class MockLoaderService: MockModuleService, LoaderService {

    var isLoading: Bool { return false }

    func showLoadingIndicator() {
        self.loggerService.log("Show loader")
    }

    func hideLoadingIndicator() {
        self.loggerService.log("Hide loader")
    }
}
