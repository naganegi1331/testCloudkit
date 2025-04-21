//
//  InputFieldAndSendData.swift
//  TestCloudKit
//
//  Created by Hiroki Kashihara on 2025/04/20.
//

import SwiftUI

struct InputFieldAndSendData: View {
    @State private var inputText: String = ""  // Holds the user input text
    var label: String
    var action: (String) -> Void               // Action to perform on button tap
    
    var body: some View {
        VStack(spacing: 16) {
            // User input field
            TextField(label, text: $inputText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)

            // Submit button
            Button("Send") {
                action(inputText)  // Pass input text to the external function
            }
            .padding()
        }
        .padding()

    }
}

#Preview {
    InputFieldAndSendData(label: "Input here") { text in
        PrintManager.outputString(text)
    }
}
