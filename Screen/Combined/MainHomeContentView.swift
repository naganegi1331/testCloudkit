import SwiftUI

struct MainHomeContentView: View {
    var body: some View {
        GeometryReader { geometry in
            VStack {
                HeaderView(label: "Welcome!")

            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .padding()
        }
    }
}

#Preview {
    MainHomeContentView()
}
