//
//  XCGLoggerService.swift
//  Musicly
//
//  Created by Egzon Pllana on 9/6/19.
//  Copyright © 2019 Native Coders. All rights reserved.
//

import XCGLogger

class XCGLoggerService: AppBaseService, LoggerService {
    override public var version: UInt { return 1 }

    private let log: XCGLogger

    override public init() {
        self.log = {
            let baseIdentifier = Bundle.main.bundleIdentifier ?? "com.egzonpllana"
            let log = XCGLogger(identifier: baseIdentifier, includeDefaultDestinations: false)

            // Customize as needed

            // Create a destination for the system console log (via NSLog)
            let systemDestination = setupConsoleDestination(with: "\(baseIdentifier).systemDestination")
            // Add the destination to the logger
            log.add(destination: systemDestination)

            // Create a file log destination
            if let documentsUrl = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true) {
                let logsFolder = documentsUrl.appendingPathComponent("logs")
                try? FileManager.default.createDirectory(at: logsFolder, withIntermediateDirectories: true)
                let fileDestination = setupFileDestination(with: "\(baseIdentifier).fileDestination", fileURL: logsFolder.appendingPathComponent("logs.txt"))
                // Add the destination to the logger
                log.add(destination: fileDestination)
            }

            // Add basic app info, version info etc, to the start of the logs
            log.logAppDetails()

            return log
        }()
        super.init()
        verboseLog("[\(type(of: self))] Start", level: .verbose)
    }

    deinit {
        verboseLog("[\(type(of: self))] Unload", level: .verbose)
    }

    public func verboseLog(_ closure: @autoclosure () -> Any?, level: LogLevel = .debug, functionName: StaticString = #function, filePath: StaticString = #file, lineNumber: Int = #line) {
        log.logln(XCGLogger.Level.level(from: level), functionName: functionName, fileName: filePath, lineNumber: lineNumber, closure: closure)
    }

}

private func setupConsoleDestination(with identifier: String) -> DestinationProtocol {
    let systemDestination = AppleSystemLogDestination(identifier: identifier)

    // Optionally set some configuration options
    #if DEBUG

    systemDestination.outputLevel = .debug
    systemDestination.showLogIdentifier = false
    systemDestination.showFunctionName = true
    systemDestination.showThreadName = true
    systemDestination.showLevel = true
    systemDestination.showFileName = true
    systemDestination.showLineNumber = true
    systemDestination.showDate = true

    #else

    systemDestination.outputLevel = .info
    systemDestination.showLogIdentifier = false
    systemDestination.showFunctionName = false
    systemDestination.showThreadName = false
    systemDestination.showLevel = true
    systemDestination.showFileName = false
    systemDestination.showLineNumber = false
    systemDestination.showDate = true

    #endif

    return systemDestination
}

private func setupFileDestination(with identifier: String, fileURL: URL) -> DestinationProtocol {
    // Create a file log destination
    let fileDestination = AutoRotatingFileDestination(writeToFile: fileURL, identifier: identifier, shouldAppend: true)

    fileDestination.targetMaxFileSize = 10 * 1024 * 1024 // 10 MBytes - Auto rotate once the file is larger than this
    fileDestination.targetMaxTimeInterval = 1 * 24 * 3600 // 1 day - Auto rotate after this many seconds
    fileDestination.targetMaxLogFiles = 10 // 10 files - Number of archived log files to keep, older ones are automatically deleted

    // Optionally set some configuration options
    #if DEBUG

    fileDestination.outputLevel = .debug
    fileDestination.showLogIdentifier = false
    fileDestination.showFunctionName = false
    fileDestination.showThreadName = false
    fileDestination.showLevel = true
    fileDestination.showFileName = false
    fileDestination.showLineNumber = false
    fileDestination.showDate = true

    #else

    fileDestination.outputLevel = .info
    fileDestination.showLogIdentifier = false
    fileDestination.showFunctionName = false
    fileDestination.showThreadName = false
    fileDestination.showLevel = true
    fileDestination.showFileName = false
    fileDestination.showLineNumber = false
    fileDestination.showDate = true

    #endif

    // Process this destination in the background
    fileDestination.logQueue = XCGLogger.logQueue

    return fileDestination
}

extension XCGLogger.Level {
    static func level(from level: LogLevel) -> XCGLogger.Level {
        switch level {
        case .verbose: return XCGLogger.Level.verbose
        case .debug: return XCGLogger.Level.debug
        case .info: return XCGLogger.Level.info
        case .warning: return XCGLogger.Level.warning
        case .error: return XCGLogger.Level.error
        case .fatal: return XCGLogger.Level.severe
        }
    }
}
