import XCTest
@testable import ArtOfWarProtocol

final class ArtOfWarProtocolTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(ArtOfWarProtocol().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
