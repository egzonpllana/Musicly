//
//  ModuleService.swift
//  Musicly
//
//  Created by Egzon Pllana on 9/6/19.
//  Copyright © 2019 Native Coders. All rights reserved.
//

import Foundation

public protocol ModuleService: BaseService {
    var loggerService: LoggerService { get }
}
