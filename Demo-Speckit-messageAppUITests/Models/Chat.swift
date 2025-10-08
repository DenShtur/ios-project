import Foundation

struct Chat: Identifiable, Codable {
    let id: String
    let name: String
    let isGroup: Bool
    let participants: [User]
    let lastMessage: Message?
}
