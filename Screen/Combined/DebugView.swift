import SwiftUI

struct DebugView: View {

    var body: some View {
        VStack(spacing: 20) {
            // Input and send to iCloud
            InputFieldAndSendData(label: "Input Message") { input in
                iCloudTestManager.sendDataToiCloud(input)
            }

            // Save test data to iCloud
            CheckStatusButton(label: "Test Save to iCloud") {
                iCloudTestManager.testSaveToCloudKit(with: "Test message")
            }

            // Check iCloud availability
            CheckStatusButton(label: "Check iCloud Connection") {
                iCloudTestManager.checkiCloudStatus()
            }

            // Fetch messages from iCloud
            CheckStatusButton(label: "Fetch Messages from iCloud") {
                iCloudTestManager.fetchMessagesFromiCloud { messages in
                    print("Fetched messages: \(messages)")
                }
            }

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
    }
}

#Preview {
    DebugView()
}
