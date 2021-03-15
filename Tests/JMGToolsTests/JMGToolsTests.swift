import XCTest
import UIKit
@testable import JMGTools

final class JMGToolsTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
//        XCTAssertEqual(JMGTools().text, "Hello, World!")
        
        let timeInterval = Date().addingTimeInterval(123123).timeIntervalSince(Date())
        let formatedInterval = timeInterval.formatSeconds()
        print(formatedInterval.hr)
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
