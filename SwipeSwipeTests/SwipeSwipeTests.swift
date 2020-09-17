//
//  SwipeSwipeTests.swift
//  SwipeSwipeTests
//
//  Created by Abhilash Ghogale on 15/09/2020.
//  Copyright © 2020 abhi. All rights reserved.
//

import XCTest
@testable import SwipeSwipe

class SwipeSwipeTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testGetResults() {
         let expct = expectation(description: "Returns json response")
        
        ResultsService().getResults { (response) in
            
            switch response {
            case .Success(let results):
                    XCTAssert(true, "Success")
                    expct.fulfill()
            case .Failure(let message):
                XCTFail(message)
            case .Error(let error):
                XCTFail(error)
            }
        }
        
        waitForExpectations(timeout: 10) { (error) in
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
            }
        }
    }

    func testImageDownload() {
        let expct = expectation(description: "Returns json response")
        ResultsService().downloadImage("https://randomuser.me/api/portraits/men/13.jpg") { (response, url) in
            switch response {
            case .Success(let _):
                XCTAssert(true, "Success")
                expct.fulfill()

            case .Failure(let message):
                XCTFail("No results")
            case .Error(let error):
                XCTFail(error)
            }

        }
        waitForExpectations(timeout: 10) { (error) in
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
            }
        }

    }

    func testImageDownloadWithBlankURL() {
        let expct = expectation(description: "Returns json response")

        
        ResultsService().downloadImage("") { (response, url) in
            switch response {
            case .Success(let _):
                XCTFail("No results")
            case .Failure(let message):
                XCTAssert(true, "Success")
                expct.fulfill()
            case .Error(let error):
                XCTFail(error)
            }

        }
        waitForExpectations(timeout: 10) { (error) in
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
            }
        }

    }

}
