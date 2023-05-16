//
//  PostTests.swift
//  EventMap
//
//  https://github.com/RyoDeveloper/EventMapTests
//  Copyright © 2023 RyoDeveloper. All rights reserved.
//

import CoreLocation
@testable import EventMap
import FirebaseFirestore
import XCTest

final class PostTests: XCTestCase {
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testDistance() {
        let coordinate = CLLocationCoordinate2D(latitude: 35.658, longitude: 139.745)
        let postCoordinate = CLLocationCoordinate2D(latitude: 35.710, longitude: 139.810)
        let post = Post(user_id: "1", title: "Title1", image_url: URL(string: "NoImage")!, geopoint: GeoPoint(latitude: postCoordinate.latitude, longitude: postCoordinate.longitude), created_at: Timestamp(date: Date()), updated_at: Timestamp(date: Date()))
        
        let distance = post.distance(from: coordinate)
        XCTAssertEqual(distance, 8240.7, accuracy: 0.1)
    }
    
    func testGetHourColor() {
        let now = Date()
        // 1時間前の場合は59秒に指定
        let oneHourAgo = Calendar.current.date(byAdding: .minute, value: -1 * 60 + 1, to: now)!
        let sixHoursAgo = Calendar.current.date(byAdding: .minute, value: -6 * 60 + 1, to: now)!
        let twelveHoursAgo = Calendar.current.date(byAdding: .minute, value: -12 * 60 + 1, to: now)!
        let twentyFourHoursAgo = Calendar.current.date(byAdding: .minute, value: -24 * 60 + 1, to: now)!
        
        let post1 = Post(user_id: "1", title: "Title1", image_url: URL(string: "NoImage")!, geopoint: GeoPoint(latitude: 0.0, longitude: 0.0), created_at: Timestamp(date: Date()), updated_at: Timestamp(date: oneHourAgo))
        let post6 = Post(user_id: "6", title: "Title2", image_url: URL(string: "NoImage")!, geopoint: GeoPoint(latitude: 0.0, longitude: 0.0), created_at: Timestamp(date: Date()), updated_at: Timestamp(date: sixHoursAgo))
        let post12 = Post(user_id: "12", title: "Title3", image_url: URL(string: "NoImage")!, geopoint: GeoPoint(latitude: 0.0, longitude: 0.0), created_at: Timestamp(date: Date()), updated_at: Timestamp(date: twelveHoursAgo))
        let post24 = Post(user_id: "24", title: "Title4", image_url: URL(string: "NoImage")!, geopoint: GeoPoint(latitude: 0.0, longitude: 0.0), created_at: Timestamp(date: Date()), updated_at: Timestamp(date: twentyFourHoursAgo))
        
        XCTAssertEqual(post1.getHourColor(), .red)
        XCTAssertEqual(post6.getHourColor(), .green)
        XCTAssertEqual(post12.getHourColor(), .blue)
        XCTAssertEqual(post24.getHourColor(), .gray)
    }
}
