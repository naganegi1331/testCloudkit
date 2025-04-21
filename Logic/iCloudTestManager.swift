import Foundation
import CloudKit

/// A utility for testing and interacting with iCloud using CloudKit.
struct iCloudTestManager {
    
    /// Identifier for the iCloud container
    private static let containerID = "iCloud.himawari"
    
    /// Returns a reference to the CloudKit container used by the app.
    private static var container: CKContainer {
        CKContainer(identifier: containerID)
    }

    /// Checks the current iCloud account availability and prints the result.
    static func checkiCloudStatus() {
        container.accountStatus { status, error in
            if let error = error {
                print("❌ iCloud unavailable: \(error.localizedDescription)")
                return
            }

            switch status {
            case .available:
                print("✅ iCloud is available")
            case .noAccount:
                print("⚠️ iCloud account is not set")
            case .restricted:
                print("🚫 iCloud access is restricted")
            default:
                print("❓ iCloud status is unknown")
            }
        }
    }

    /// Sends a string value to the iCloud public database.
    static func sendDataToiCloud(_ data: String) {
        let publicDatabase = container.publicCloudDatabase

        let record = CKRecord(recordType: "Message")
        record["text"] = data as CKRecordValue

        publicDatabase.save(record) { _, error in
            if let error = error {
                print("❌ Failed to save data: \(error.localizedDescription)")
            } else {
                print("✅ Data successfully saved: \(data)")
            }
        }
    }

    /// Tests saving data to CloudKit with detailed error diagnostics.
    static func testSaveToCloudKit(with text: String) {
        let publicDatabase = container.publicCloudDatabase

        let record = CKRecord(recordType: "Message")
        record["text"] = text as CKRecordValue

        publicDatabase.save(record) { _, error in
            if let error = error as? CKError {
                print("❌ Failed to save data to CloudKit.")
                print("Error code: \(error.code.rawValue) - \(error.localizedDescription)")

                switch error.code {
                case .networkUnavailable:
                    print("🌐 Network unavailable")
                case .notAuthenticated:
                    print("⚠️ Not signed into iCloud")
                case .permissionFailure:
                    print("🔒 Permission failure")
                case .quotaExceeded:
                    print("📦 Quota exceeded")
                case .invalidArguments:
                    print("⚠️ Invalid arguments")
                case .serverRejectedRequest:
                    print("🚫 Server rejected request")
                case .internalError:
                    print("🛠 Internal server error")
                default:
                    print("❓ Unknown error: \(error)")
                }
            } else {
                print("✅ Data successfully saved to iCloud: \(text)")
            }
        }
    }

    /// Fetches all Message records from the public CloudKit database.
    static func fetchMessagesFromiCloud(cursor: CKQueryOperation.Cursor? = nil, accumulatedMessages: [String] = [], completion: @escaping ([String]) -> Void) {
        let publicDatabase = container.publicCloudDatabase
        var allMessages = accumulatedMessages

        let operation: CKQueryOperation
        if let cursor = cursor {
            operation = CKQueryOperation(cursor: cursor)
        } else {
            let query = CKQuery(recordType: "Message", predicate: NSPredicate(value: true))
            query.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
            operation = CKQueryOperation(query: query)
            operation.desiredKeys = ["text"]
        }

        operation.recordFetchedBlock = { record in
            if let text = record["text"] as? String {
                allMessages.append(text)
            }
        }

        operation.queryCompletionBlock = { newCursor, error in
            if let error = error as? CKError {
                print("❌ Failed to fetch messages from iCloud.")
                print("Error code: \(error.code.rawValue) - \(error.localizedDescription)")

                switch error.code {
                case .networkUnavailable:
                    print("🌐 Network unavailable")
                case .notAuthenticated:
                    print("⚠️ Not signed into iCloud")
                case .permissionFailure:
                    print("🔒 Permission failure")
                case .quotaExceeded:
                    print("📦 Quota exceeded")
                case .invalidArguments:
                    print("⚠️ Invalid arguments")
                case .serverRejectedRequest:
                    print("🚫 Server rejected request")
                case .internalError:
                    print("🛠 Internal server error")
                default:
                    print("❓ Unknown error: \(error)")
                }
                completion([])
            } else if let newCursor = newCursor {
                // Continue fetching next page
                fetchMessagesFromiCloud(cursor: newCursor, accumulatedMessages: allMessages, completion: completion)
            } else {
                print("✅ Successfully fetched \(allMessages.count) message(s) from iCloud.")
                completion(allMessages)
            }
        }

        publicDatabase.add(operation)
    }
}
