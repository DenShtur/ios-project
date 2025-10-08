import Foundation

enum MediaType: String, Codable {
    case image
    case video
    case sticker
}

struct Media: Identifiable, Codable {
    let id: String
    let type: MediaType
    let url: URL
    let thumbnailURL: URL?
}
