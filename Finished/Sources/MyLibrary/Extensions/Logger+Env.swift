import Foundation
import Logging

public extension Logger {

    static func env(
        _ id: String,
        logLevel: Logger.Level = .info
    ) -> Logger {
        var logger = Logger(label: id)
        logger.logLevel = logLevel

        let env = ProcessInfo.processInfo.environment
        if let rawLevel = env["LOG_LEVEL"]?.lowercased(),
            let level = Logger.Level(rawValue: rawLevel)
        {
            logger.logLevel = level
        }

        let envKey =
            id
            .appending("-log-level")
            .replacingOccurrences(of: "-", with: "_")
            .uppercased()
        if let rawLevel = env[envKey]?.lowercased(),
            let level = Logger.Level(rawValue: rawLevel)
        {
            logger.logLevel = level
        }
        return logger
    }
}

