import EnvironmentMacro
import SwiftUI

let a = 17
let b = 25

struct MyView: View {
    #Environment(\.dynamicTypeSize)

    var body: some View {
        Text("foo")
            .dynamicTypeSize(dynamicTypeSize)
    }
}

print(Mirror(reflecting: MyView.self))
