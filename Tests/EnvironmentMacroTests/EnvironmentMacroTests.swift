import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest

// Macro implementations build for the host, so the corresponding module is not available when cross-compiling. Cross-compiled tests may still make use of the macro itself in end-to-end tests.
#if canImport(EnvironmentMacroMacros)
import EnvironmentMacroMacros

let testMacros: [String: Macro.Type] = [
    "Environment": EnvironmentMacro.self,
]
#endif

final class EnvironmentMacroTests: XCTestCase {
    func testMacro() throws {
        #if canImport(EnvironmentMacroMacros)
        assertMacroExpansion(
            """
            #Environment(\\.isEnabled)
            """,
            expandedSource: """
            @Environment(\\.isEnabled) private var isEnabled
            """,
            macros: testMacros
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }

//    func testMacroWithStringLiteral() throws {
//        #if canImport(EnvironmentMacroMacros)
//        assertMacroExpansion(
//            #"""
//            #stringify("Hello, \(name)")
//            """#,
//            expandedSource: #"""
//            ("Hello, \(name)", #""Hello, \(name)""#)
//            """#,
//            macros: testMacros
//        )
//        #else
//        throw XCTSkip("macros are only supported when running tests for the host platform")
//        #endif
//    }
}
