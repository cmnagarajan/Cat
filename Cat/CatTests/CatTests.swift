//
//  CatTests.swift
//  CatTests
//
//  Created by Nags on 12/17/22.
//

import XCTest
@testable import Cat

final class CatTests: XCTestCase {
    
    var catModel : Cat!
    var catServiceMock : CatServiceProtocolMock!

    override func setUpWithError() throws {
        catModel = Cat(imageURL: "https://meowfacts.herokuapp.com/", fact:"This is cat")
        catServiceMock = CatServiceProtocolMock()
    }

    override func tearDownWithError() throws {
        catModel = nil
        catServiceMock = nil
    }

    func testDidFetch() throws {
        catModel.catService = catServiceMock
        catModel.didFetch(withSuccess: { (success) in
            debugPrint("Success")
        }) { (err) in
            debugPrint("Error happened", err as Any)
        }
        XCTAssertTrue(catServiceMock.fetchCatFactCompletionCalled)
        XCTAssertTrue(catServiceMock.fetchCatFactCompletionCallsCount > 0)
    }
}
