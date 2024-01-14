import SwiftUI

/// A macro that produces both a value and a string containing the
/// source code that generated the value. For example,
///
///     #stringify(x + y)
///
/// produces a tuple `(x + y, "x + y")`.
@freestanding(declaration, names: arbitrary)
public macro Environment<Value>(_ keyPath: KeyPath<EnvironmentValues, Value>) = #externalMacro(module: "EnvironmentMacroMacros", type: "EnvironmentMacro")
