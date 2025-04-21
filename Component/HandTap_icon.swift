//
//  Button_icon.swift
//  TestCloudKit
//
//  Created by Hiroki Kashihara on 2025/04/19.
//

import SwiftUI

struct HandTap_icon: View {
    var action: () -> Void
    
    var body: some View {
        Button(action: {
            action()

        }){
            //button icon setting here
            Image(systemName: "hand.tap.fill")
                .resizable()
                .frame(width: 32, height: 32)
                .foregroundColor(.blue)
        }.buttonStyle(PlainButtonStyle())

    }
}

#Preview {
    HandTap_icon(action: PrintManager.ReportTestCommence)
}
