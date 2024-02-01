import Foundation
import Logging

public extension Logger {

    
    ///
    /// Creates a custom logger using a subsystem identifier and a log level.
    ///
    /// This method allows users to specify the log level for each subsystem, baded on environment variables:
    /// - Set the `LOG_LEVEL` environment variable to override all subsystem log levels.
    /// - Set a custom `{id}_LOG_LEVEL` variable to override the log level for a given subsystem.
    ///
    /// - Note: When looking for environmental variables, the provided logger id is automatically lowercased, dashes (`-`) are always replaced with underscores (`_`) and a `_LOG_LEVEL` suffix is added to the id.
    ///
    /// **Example**
    ///
    /// ```swift
    /// let libLogger = Logger.subsystem("my-lib", .notice)   
    /// let appLogger = Logger.subsystem("my-app", .notice)   
    /// ```
    /// **Environmental variables**
    /// ```sh
    /// LOG_LEVEL=info MY_LIB_LOG_LEVEL=trace swift run MyApp
    /// ```
    /// **Expected log levels**
    /// - libLogger = `.trace`
    /// - appLogger = `.info`
    ///
    /// - Parameters:
    ///   - id: The identifier of the logger subsystem, used as the label for the logger.
    ///   - level: Custom log level for the logger (default value: `.info`).
    /// - Returns: A `Logger` instance
    static func subsystem(
        _ id: String,
        _ level: Logger.Level = .info
    ) -> Logger {
        var logger = Logger(label: id)
        logger.logLevel = level

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

