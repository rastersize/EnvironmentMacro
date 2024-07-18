// swift-tools-version: 6.0

import PackageDescription
import CompilerPluginSupport

let package = Package(
    name: "EnvironmentMacro",
    platforms: [.macOS(.v12), .iOS(.v15), .tvOS(.v15), .watchOS(.v8), .macCatalyst(.v15)],
    products: [
        .library(
            name: "EnvironmentMacro",
            targets: ["EnvironmentMacro"]
        ),
        .executable(
            name: "EnvironmentMacroClient",
            targets: ["EnvironmentMacroClient"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-syntax.git", from: "600.0.0-prerelease-2024-06-12"),
    ],
    targets: [
        // Macro implementation that performs the source transformation of a macro.
        .macro(
            name: "EnvironmentMacroMacros",
            dependencies: [
                .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
                .product(name: "SwiftCompilerPlugin", package: "swift-syntax")
            ]
        ),

        // Library that exposes a macro as part of its API, which is used in client programs.
        .target(name: "EnvironmentMacro", dependencies: ["EnvironmentMacroMacros"]),

        // A client of the library, which is able to use the macro in its own code.
        .executableTarget(name: "EnvironmentMacroClient", dependencies: ["EnvironmentMacro"]),

        // A test target used to develop the macro implementation.
        .testTarget(
            name: "EnvironmentMacroTests",
            dependencies: [
                "EnvironmentMacroMacros",
                .product(name: "SwiftSyntaxMacrosTestSupport", package: "swift-syntax"),
            ]
        ),
    ]
)
