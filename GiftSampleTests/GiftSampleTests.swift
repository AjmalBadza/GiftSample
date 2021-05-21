//
//  GiftSampleTests.swift
//  GiftSampleTests
//

//

import XCTest
@testable import GiftSample

class GiftSampleTests: XCTestCase {

    func testModel() throws {
       let vieModel = HomeViewModel()
        let expectation = self.expectation(description: "testFeed")
        
        vieModel.loadHome { (string) in
            XCTAssertEqual("Success", string)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 6, handler: nil)
    }
    func testFeed() throws {
       let api = ServerApi()
        let expectation = self.expectation(description: "testFeed")
        api.getHomeFeeds { (result) in
            switch result {
                case .failure(let error):
                    XCTFail("Expected to be a success but got a failure with \(error)")
                case .success(let value):
                    XCTAssertNotNil(value)
                }
            expectation.fulfill()
        }
        
        
        waitForExpectations(timeout: 6, handler: nil)
    }
    func testBrands() throws {
       let api = ServerApi()
        let expectation = self.expectation(description: "testBrands")
        api.getBrands(categoryId: 32,Page: 2) { (result) in
            switch result {
                case .failure(let error):
                    XCTFail("Expected to be a success but got a failure with \(error)")
                case .success(let value):
                    XCTAssertNotNil(value)
                }
            expectation.fulfill()
        }
        
        
        waitForExpectations(timeout: 6, handler: nil)
    }
   
    
}
