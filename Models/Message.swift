import Foundation

struct Message: Identifiable, Codable {
    let id: String
    let chatId: String
    let sender: User
    let text: String?
    let media: Media?
    let timestamp: Date
    let isRead: Bool
}
