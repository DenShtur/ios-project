import Foundation

struct User: Identifiable, Codable {
    let id: String
    let name: String
    let avatarURL: URL?
    let status: String?
}
