//
//  PostViewModelTests.swift
//  EventMap
//
//  https://github.com/RyoDeveloper/EventMapTests
//  Copyright © 2023 RyoDeveloper. All rights reserved.
//

@testable import EventMap
import FirebaseFirestore
import XCTest

final class PostViewModelTests: XCTestCase {
    var viewModel: PostViewModel!
    
    override func setUpWithError() throws {
        super.setUp()
        viewModel = PostViewModel()
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
        super.tearDown()
    }
    
    func testGetMapURL() throws {
        let geopoint = GeoPoint(latitude: 35.658, longitude: 139.745)
        let title = "Tokyo Tower"
        let url = viewModel.getMapURL(geopoint: geopoint, title: title)
        XCTAssertNotNil(url)
        XCTAssertEqual(url.absoluteString, "http://maps.apple.com/?ll=35.658,139.745&q=Tokyo%20Tower")
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
