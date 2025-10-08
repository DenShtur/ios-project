import XCTest
@testable import Demo_Speckit_messageApp

class ChatModelTests: XCTestCase {
    func testChatInitialization() {
        let user = User(id: "1", name: "Test", avatarURL: nil, status: nil)
        let chat = Chat(id: "c1", name: "Test Chat", isGroup: false, participants: [user], lastMessage: nil)
        XCTAssertEqual(chat.id, "c1")
        XCTAssertEqual(chat.name, "Test Chat")
        XCTAssertFalse(chat.isGroup)
        XCTAssertEqual(chat.participants.count, 1)
    }
}
