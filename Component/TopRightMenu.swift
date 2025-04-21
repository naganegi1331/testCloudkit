import SwiftUI

// The TopRightMenu struct conforms to ToolbarContent to provide content for a toolbar.
struct TopRightMenu: ToolbarContent {
    // @Binding allows the selectedMenu variable to be a reference to a state variable from a parent view.
    @Binding var selectedMenu: String?
    // menuItems is an array of tuples that contains the title and value for each menu item.
    // It is passed in to allow customization of the menu items displayed.
    var menuItems: [(title: String, value: String)]

    var body: some ToolbarContent {
        // ToolbarItem is used to define a single item in the toolbar.
        ToolbarItem(placement: .navigationBarTrailing) {
            // Menu creates a dropdown menu that displays the items when tapped.
            Menu {
                // ForEach iterates over the menuItems array, creating a button for each item.
                ForEach(menuItems, id: \.value) { item in
                    Button(item.title) {
                        // When a button is tapped, selectedMenu is updated with the corresponding value.
                        selectedMenu = item.value
                    }
                }
            } label: {
                // The label for the Menu, which displays an ellipsis icon.
                Image(systemName: "ellipsis")
            }
        }
    }
}
