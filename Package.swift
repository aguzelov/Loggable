// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Loggable",
	platforms: [.iOS(.v16), .macOS(.v11)],
	products: [
		.library(name: "Loggable", targets: ["Loggable"])
	],
	targets: [
		.target(name: "Loggable"),
		.testTarget(name: "LoggableTests", dependencies: ["Loggable"]),
	]
)
