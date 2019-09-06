//
//  MockModuleService.swift
//  Musicly
//
//  Created by Egzon Pllana on 9/6/19.
//  Copyright © 2019 Native Coders. All rights reserved.
//

import Foundation

class MockModuleService: MockBaseService, ModuleService, HasDependencies {
    private(set) lazy var loggerService: LoggerService = dependencies.loggerService()

    override init() {
        super.init()
        self.loggerService.log("[MOCK][\(type(of: self))] Load with version \(self.version)")
    }

    deinit {
        self.loggerService.log("[MOCK][\(type(of: self))] Unload")
    }
}
