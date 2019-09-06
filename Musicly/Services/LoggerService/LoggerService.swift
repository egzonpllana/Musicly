//
//  LoggerService.swift
//  Musicly
//
//  Created by Egzon Pllana on 9/6/19.
//  Copyright © 2019 Native Coders. All rights reserved.
//

import Foundation

public enum LogLevel: String {
    case verbose = "Verbose"
    case debug = "Debug"
    case info = "Info"
    case warning = "Warning"
    case error = "Error"
    case fatal = "Fatal"
}

public protocol LoggerService: BaseService {
    func verboseLog(_ closure: @autoclosure () -> Any?, level: LogLevel, functionName: StaticString, filePath: StaticString, lineNumber: Int)
}

public extension LoggerService {
    func log(_ closure: @autoclosure () -> Any?, level: LogLevel = .debug, functionName: StaticString = #function, filePath: StaticString = #file, lineNumber: Int = #line) {
        verboseLog(closure(), level: level, functionName: functionName, filePath: filePath, lineNumber: lineNumber)
    }
}

#if DEBUG
extension QualityOfService: CustomStringConvertible {
    public var description: String {
        switch self {
        case .userInteractive: return "userInteractive"
        case .userInitiated: return "userInitiated"
        case .utility: return "utility"
        case .background: return "background"
        case .`default`: return "default"
        @unknown default:
            assert(false, "QualityOfService case not handled")
            return "unknown"
        }
    }
}
#endif
