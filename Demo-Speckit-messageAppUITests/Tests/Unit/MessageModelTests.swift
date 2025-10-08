import XCTest
@testable import Demo_Speckit_messageApp

class MessageModelTests: XCTestCase {
    func testMessageInitialization() {
        let user = User(id: "1", name: "Test", avatarURL: nil, status: nil)
        let media = Media(id: "m1", type: .image, url: URL(string: "https://example.com/image.png")!, thumbnailURL: nil)
        let message = Message(id: "msg1", chatId: "c1", sender: user, text: "Hello", media: media, timestamp: Date(), isRead: false)
        XCTAssertEqual(message.id, "msg1")
        XCTAssertEqual(message.chatId, "c1")
        XCTAssertEqual(message.sender.id, "1")
        XCTAssertEqual(message.text, "Hello")
        XCTAssertEqual(message.media?.id, "m1")
    }
}
