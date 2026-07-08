import XCTest
import os
@testable import Loggable

private struct Widget: Loggable {}

final class LoggableTests: XCTestCase {
	func testAllLevelsLogWithoutCrashing() {
		let widget = Widget()
		widget.logDebug("debug", subsystem: "com.loggable.tests")
		widget.logInfo("info", subsystem: "com.loggable.tests")
		widget.logError("error", subsystem: "com.loggable.tests")
		widget.logFault("fault", subsystem: "com.loggable.tests")
		widget.logWarning("warning", subsystem: "com.loggable.tests")
	}

	func testDefaultSubsystemIsUsedWhenOmitted() {
		Widget().logInfo("info without explicit subsystem")
	}

	func testPublicPrivacyDoesNotCrash() {
		Widget().logInfo("public message", subsystem: "com.loggable.tests", privacy: .public)
	}

	func testLogLevelDefaultsToDebug() {
		Widget().log("defaults to debug level", subsystem: "com.loggable.tests")
	}
}
