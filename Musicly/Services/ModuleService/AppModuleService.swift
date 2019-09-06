//
//  AppModuleService.swift
//  Musicly
//
//  Created by Egzon Pllana on 9/6/19.
//  Copyright © 2019 Native Coders. All rights reserved.
//

import Foundation

class AppModuleService: AppBaseService, ModuleService, HasDependencies {
    public private(set) lazy var loggerService: LoggerService = dependencies.loggerService()

    override public init() {
        super.init()
        self.loggerService.log("[\(type(of: self))] Load with version \(self.version)", level: .verbose)
    }

    deinit {
        self.loggerService.log("[\(type(of: self))] Unload", level: .verbose)
    }
}
