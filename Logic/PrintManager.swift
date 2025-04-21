//
//  Hello.swift
//  TestCloudKit
//
//  Created by Hiroki Kashihara on 2025/04/19.
//

import Foundation

struct PrintManager {
    static func Sayhello(){
        print("Hello, World!")
    }
    static func ReportTestCommence(){
        print("Test Commence")
    }
    
    /// Outputs the user's input with a prefixed message.
    static func outputString(_ text: String) {
        print("Your input is: \(text)")
    }
}
