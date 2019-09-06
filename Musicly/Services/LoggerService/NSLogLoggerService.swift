//
//  NSLogLoggerService.swift
//  Musicly
//
//  Created by Egzon Pllana on 9/6/19.
//  Copyright © 2019 Native Coders. All rights reserved.
//

import Foundation

class NSLogLoggerService: AppBaseService, LoggerService {
    override public var version: UInt { return 1 }

    override public init() {
        super.init()
        verboseLog("[\(type(of: self))] Load with version \(self.version)", level: .verbose)
    }

    deinit {
        verboseLog("[\(type(of: self))] Unload", level: .verbose)
    }

    public func verboseLog(_ closure: @autoclosure () -> Any?, level: LogLevel = .debug, functionName: StaticString = #function, filePath: StaticString = #file, lineNumber: Int = #line) {
        guard let message = closure() else { return }
        #if DEBUG
        let fileName: String = URL(fileURLWithPath: filePath.description).lastPathComponent
        let threadName: String
        if Thread.isMainThread {
            threadName = "main"
        } else if let name = Thread.current.name, !name.isEmpty {
            threadName = name
        } else {
            threadName = Thread.current.qualityOfService.description
        }
        NSLog("[\(level.rawValue)] [\(threadName)] [\(fileName):\(lineNumber)] \(functionName) > \(message)")
        #else
        NSLog("\(message)")
        #endif
    }
}
