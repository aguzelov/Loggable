//
//  Loggable.swift
//  Torbichka-Logger
//
//  Created by Clax on 20.09.25.
//

import Foundation
import os

public enum LogPrivacy: Sendable {
	case `private`
	case `public`
}

public protocol Loggable {
	func log(level: OSLogType, _ message: String, subsystem: String, privacy: LogPrivacy, function: String, line: Int)
}

public extension Loggable {
	func log(level: OSLogType = .debug, _ message: String, subsystem: String = Bundle.main.bundleIdentifier ?? "unknown", privacy: LogPrivacy = .private, function: String = #function, line: Int = #line) {
		let type = type(of: self)
		let logger = os.Logger(subsystem: subsystem, category: "\(type)")

		var symbol = ""
		switch level {
			case .info:
				symbol = "ℹ️"
			case .error:
				symbol = "❌"
			case .fault:
				symbol = "💥"
			default:
				break
		}
		let time = Date()
		switch privacy {
			case .private:
				logger.log(level: level, "\(symbol) \(time) => \(type):\(line):\(function) -> \(message, privacy: .private)")
			case .public:
				logger.log(level: level, "\(symbol) \(time) => \(type):\(line):\(function) -> \(message, privacy: .public)")
		}
	}

	func logDebug(_ message: String, subsystem: String = Bundle.main.bundleIdentifier ?? "unknown", privacy: LogPrivacy = .private, function: String = #function, line: Int = #line) {
#if DEBUG
		log(level: .debug, message, subsystem: subsystem, privacy: privacy, function: function, line: line)
#endif
	}

	func logInfo(_ message: String, subsystem: String = Bundle.main.bundleIdentifier ?? "unknown", privacy: LogPrivacy = .private, function: String = #function, line: Int = #line) {
		log(level: .info, message, subsystem: subsystem, privacy: privacy, function: function, line: line)
	}

	func logError(_ message: String, subsystem: String = Bundle.main.bundleIdentifier ?? "unknown", privacy: LogPrivacy = .private, function: String = #function, line: Int = #line) {
		log(level: .error, message, subsystem: subsystem, privacy: privacy, function: function, line: line)
	}

	func logFault(_ message: String, subsystem: String = Bundle.main.bundleIdentifier ?? "unknown", privacy: LogPrivacy = .private, function: String = #function, line: Int = #line) {
		log(level: .fault, message, subsystem: subsystem, privacy: privacy, function: function, line: line)
	}

	func logWarning(_ message: String, subsystem: String = Bundle.main.bundleIdentifier ?? "unknown", privacy: LogPrivacy = .private, function: String = #function, line: Int = #line) {
		let message = "⚠️ \(message)"
		log(message, subsystem: subsystem, privacy: privacy, function: function, line: line)
	}
}
