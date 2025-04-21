import SwiftUI

struct HomeView: View {
    @State private var selectedMenu: String? = nil
    
    var body: some View {
        NavigationStack {
            MainHomeContentView()
                .toolbar {
                    TopRightMenu(
                        selectedMenu: $selectedMenu,
                        menuItems: [
                            (title: "Go to Settings", value: "settings"),
                            (title: "Go to Debug", value: "debug")
                        ]
                    )
                }
            
            // Handles navigation based on selected menu value
            MenuNavigationRouter(selected: $selectedMenu)
        }
    }
}

#Preview {
    HomeView()
}
