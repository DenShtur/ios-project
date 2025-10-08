import XCTest
@testable import Demo_Speckit_messageApp

class MediaModelTests: XCTestCase {
    func testMediaInitialization() {
        let media = Media(id: "m1", type: .video, url: URL(string: "https://example.com/video.mp4")!, thumbnailURL: nil)
        XCTAssertEqual(media.id, "m1")
        XCTAssertEqual(media.type, .video)
        XCTAssertEqual(media.url.absoluteString, "https://example.com/video.mp4")
    }
}
