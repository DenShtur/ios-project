import XCTest
@testable import Demo_Speckit_messageApp

class MattermostAPIServiceTests: XCTestCase {
    func testFetchChatsStub() {
        let service = MattermostAPIService()
        let expectation = self.expectation(description: "Fetch chats")
        service.fetchChats { result in
            // TODO: Replace with mock or stub
            expectation.fulfill()
        }
        waitForExpectations(timeout: 2)
    }
    // Аналогично для других методов: fetchMessages, sendMessage, uploadMedia
}
