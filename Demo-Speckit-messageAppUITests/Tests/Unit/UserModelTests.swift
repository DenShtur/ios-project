import XCTest
@testable import Demo_Speckit_messageApp

class UserModelTests: XCTestCase {
    func testUserInitialization() {
        let user = User(id: "1", name: "Test", avatarURL: nil, status: "online")
        XCTAssertEqual(user.id, "1")
        XCTAssertEqual(user.name, "Test")
        XCTAssertEqual(user.status, "online")
    }
}
