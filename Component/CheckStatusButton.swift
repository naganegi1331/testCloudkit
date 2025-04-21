import SwiftUI

/// A reusable button component that adapts to light/dark mode and performs a custom action.
struct CheckStatusButton: View {
    
    // Detect system color scheme to apply appropriate styling
    @Environment(\.colorScheme) var colorScheme

    /// The label text displayed on the button
    var label: String

    /// The action to perform when the button is tapped
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(label)
                .font(.system(size: 20, weight: .bold)) // Bold, readable text
                .foregroundStyle(colorScheme == .dark ? .black : .white) // Adjust text color
                .frame(width: 300, height: 30) // Fixed size for consistency
                .padding()
                .background(colorScheme == .dark ? Color.white : Color.black) // Adaptive background
                .cornerRadius(10)
                .padding(.horizontal, 20)
        }
    }
}

// The #Preview block allows for live previews of the SwiftUI view in Xcode
#Preview {
    CheckStatusButton(label: "Check button here", action: PrintManager.ReportTestCommence)
}
