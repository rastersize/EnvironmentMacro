# EnvironmentMacro

> [!WARNING]  
> Due to a [bug in the Swift 5.9 (at least 5.9.2) compiler](https://github.com/apple/swift/issues/70807) this macro
> crashes the compiler

Swift macro that reduce the boilerplate of SwiftUI’s `@Environment` property wrapper. Removing the need to write out
the `private var <nameOfProperty>` boilerplate each time.

## Usage

The package defines a freestanding declaration macro `#Environment` that takes a key-path to a value on SwiftUI’s
`EnvironmentValues` type. It expands this into an `@Environment` expression.

```swift
struct UserView: View {
    let user: User

    // Adds an observation of the `dynamicTypeSize` environment value
    #Environment(\.dynamicTypeSize)
    // Expands into:
    // @Environment(\.dynamicTypeSize) private var dynamicTypeSize

    var body: some View {
        Text(user.displayName)
            .foregroundStyle(dynamicTypeSize > .xLarge ? .green : .blue)
    }
}
```
