//
//  HeaderView.swift
//  TestCloudKit
//
//  Created by Hiroki Kashihara on 2025/04/19.
//

import SwiftUI

struct HeaderView: View {
    var label: String
    
    var body: some View {
        Text(label).font(.largeTitle)
    }
}

#Preview {
    HeaderView(label: "Welcome!")
}
