import SwiftUI

struct MenuNavigationRouter: View {
    @Binding var selected: String?

    var body: some View {
        Group {
            NavigationLink(destination: SettingsView(), tag: "settings", selection: $selected) {
                EmptyView()
            }
            NavigationLink(destination: DebugView(), tag: "debug", selection: $selected) {
                EmptyView()
            }
        }
    }
}
