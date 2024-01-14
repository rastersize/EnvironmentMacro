import SwiftCompilerPlugin
import SwiftDiagnostics
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

struct NoKeyPathDiagnosticMessage: DiagnosticMessage {
    let message: String = "No SwiftUI EnvironmentValues keypath provided"
    let diagnosticID = MessageID(domain: "EnvironmentMacro", id: "noKeyPath")
    let severity: DiagnosticSeverity = .error
}

///
///
///
/// Conversion:
/// ```swift
/// #Environment(\.somePropertyOnEnvironmentValues)
/// ->
/// @Environment(\.somePropertyOnEnvironmentValues) private var somePropertyOnEnvironmentValues
///
/// ```
public struct EnvironmentMacro: DeclarationMacro {
    public static func expansion(
        of node: some FreestandingMacroExpansionSyntax,
        in context: some MacroExpansionContext
    ) throws -> [DeclSyntax] {
        // TODO: Verify that the expression is in a SwiftUI `View` or `DynamicProperty`

        guard
            // Get the key path argument (`\.somePropertyOnEnvironmentValues`)
            let keyPathExpression = node.argumentList.first?.expression.as(KeyPathExprSyntax.self),
            // Get the AST component that contains the name of the key path (`somePropertyOnEnvironmentValues`)
            let keyPathComponent = keyPathExpression.components.first?.component.as(KeyPathPropertyComponentSyntax.self)
        else {
            context.diagnose(Diagnostic(node: Syntax(node), message: NoKeyPathDiagnosticMessage()))
            return []
        }

        let keyPathName = keyPathComponent.declName.baseName

//        return ["@Environment(\\.\(keyPathName)) private var \(keyPathName)"]
        return ["@Environment(\\.\(keyPathName)) private var \(keyPathName)"]
    }
}

@main
struct EnvironmentMacroPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        EnvironmentMacro.self,
    ]
}
