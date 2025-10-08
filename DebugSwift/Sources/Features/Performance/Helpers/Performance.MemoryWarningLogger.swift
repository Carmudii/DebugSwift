//
//  Performance.MemoryWarning.swift
//  DebugSwift
//
//  Created by Carmudi on 08/10/25.
//

import os.log

final class MemoryWarningLogger {
    private enum Level {
        case info
        case warning
        case debug
        case error
    }

    private let subsystem = "DebugSwift"
    private let category = "MemoryWarning"
    private let osLog: OSLog

    init() {
        osLog = OSLog(subsystem: subsystem, category: category)
    }

    func info(_ message: String) {
        log(message, level: .info)
    }

    func warning(_ message: String) {
        log(message, level: .warning)
    }

    func debug(_ message: String) {
        log(message, level: .debug)
    }

    func error(_ message: String) {
        log(message, level: .error)
    }

    private func log(_ message: String, level: Level) {
        if #available(iOS 14.0, *) {
            let logger = Logger(subsystem: subsystem, category: category)
            switch level {
            case .info:
                logger.info("\(message, privacy: .public)")
            case .warning:
                logger.warning("\(message, privacy: .public)")
            case .debug:
                logger.debug("\(message, privacy: .public)")
            case .error:
                logger.error("\(message, privacy: .public)")
            }
        } else {
            let type: OSLogType
            switch level {
            case .info:
                type = .info
            case .warning:
                type = .default
            case .debug:
                type = .debug
            case .error:
                type = .error
            }
            os_log("%{public}@", log: osLog, type: type, message)
        }
    }
}
