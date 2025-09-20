//
//  Loggable.swift
//  Torbichka-Logger
//
//  Created by Clax on 20.09.25.
//

import Foundation
import os

public protocol Loggable {
	func log(level: OSLogType, _ message: String, subsystem: String, function: String, line: Int)
}

public extension Loggable {
	func log(level: OSLogType = .debug, _ message: String, subsystem: String, function: String = #function, line: Int = #line) {
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
		logger.log(level: level, "\(symbol) \(time) => \(type):\(line):\(function) -> \(message)")
	}
	
	func logDebug(_ message: String, subsystem: String, function: String = #function, line: Int = #line) {
		log(level: .debug, message, subsystem: subsystem, function: function, line: line)
	}
	
	func logInfo(_ message: String, subsystem: String, function: String = #function, line: Int = #line) {
		log(level: .info, message, subsystem: subsystem, function: function, line: line)
	}
	
	func logError(_ message: String, subsystem: String, function: String = #function, line: Int = #line) {
		log(level: .error, message, subsystem: subsystem, function: function, line: line)
	}
	
	func logFault(_ message: String, subsystem: String, function: String = #function, line: Int = #line) {
		log(level: .fault, message, subsystem: subsystem, function: function, line: line)
	}
	
	func logWarning(_ message: String, subsystem: String, function: String = #function, line: Int = #line) {
		let message = "⚠️ \(message)"
		log(message, subsystem: subsystem, function: function, line: line)
	}
}

