//
//  CollisionDetectionTests.swift
//  CGUtilsTests
//
//  Created by Nicolás Miari on 2019/07/01.
//  Copyright © 2019 Nicolás Miari. All rights reserved.
//

import XCTest
@testable import CGUtils

class CollisionDetectionTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testIfSegmentsIntersect() {

        // [1] Horizontal segment around origin:
        let p1 = CGPoint(x: -1, y: 0)
        let p2 = CGPoint(x: +1, y: 0)
        let s1 = CGSegment(start: p1, end: p2)

        // Test against self:
        XCTAssertTrue(segment(s1, intersects: s1))

        // [2] Vertical segment around origin:
        let p3 = CGPoint(x: 0, y: -1)
        let p4 = CGPoint(x: 0, y: +1)
        let s2 = CGSegment(start: p3, end: p4)

        // Test against self:
        XCTAssertTrue(segment(s2, intersects: s2))

        // Test against s1:
        XCTAssertTrue(segment(s2, intersects: s1))
        XCTAssertTrue(segment(s1, intersects: s2))

        // [3] Vertical segment just above the origin:
        let p5 = CGPoint(x: 0, y: 0.00001)
        let s3 = CGSegment(start: p4, end: p5)

        // Test against s1
        XCTAssertFalse(segment(s1, intersects: s3))
        XCTAssertFalse(segment(s3, intersects: s1))

        // Test against s2
        XCTAssertTrue(segment(s2, intersects: s3))
        XCTAssertTrue(segment(s3, intersects: s2))

        // [4] Vertical segment adjascent to s1:
        let p6 = CGPoint(x: +1, y: 1)
        let s4 = CGSegment(start: p2, end: p6)

        XCTAssertTrue(segment(s1, intersects: s4))

        // [5] Diagonal segments
        let p7 = CGPoint(x: -1, y: -1)
        let p8 = CGPoint(x: +2, y: +2)
        let s5 = CGSegment(start: p7, end: p8)

        let p9 = CGPoint(x: -3, y: +3)
        let p10 = CGPoint(x: +4, y: -4)
        let s6 = CGSegment(start: p9, end: p10)

        XCTAssertTrue(segment(s5, intersects: s6))
    }

    func testSegmentIntersectionPoints() {

        let p0 = CGPoint.zero
        let p1 = CGPoint(x: 2, y: 1)
        let p2 = CGPoint(x: 1, y: 0)
        let p3 = CGPoint(x: 1, y: 1)

        let s1 = CGSegment(start: p0, end: p1) // Diagonal 1/2 slope from origin
        let s2 = CGSegment(start: p2, end: p3) // Vertical at x = 1

        guard let ip1 = segmentIntersection(between: s1, and: s2) else {
            return XCTFail("Segments should cross")
        }
        // Should cross at x=1, y=0.5:
        XCTAssertEqual(ip1, CGPoint(x: 1, y: 0.5))

        // Upper half of s2)
        let p4 = CGPoint(x: 1, y: 0.5)
        let s3 = CGSegment(start: p3, end: p4)

        guard let ip2 = segmentIntersection(between: s1, and: s3) else {
            return XCTFail("Segments should touch")
        }
        // Should touch at x=1, y=0.5:
        XCTAssertEqual(ip2, p4)

        // Try a vertical segment...
        let p5 = CGPoint(x: 0, y: 3)
        let s4 = CGSegment(start: p0, end: p5)

        let p6 = CGPoint(x: -2, y: 1)
        let p7 = CGPoint(x: +1, y: 1)
        let s5 = CGSegment(start: p6, end: p7)

        guard let ip3 = segmentIntersection(between: s4, and: s5) else {
            return XCTFail("Segments should touch")
        }
        XCTAssertEqual(ip3, CGPoint(x: 0, y: 1))

        // Try disjoint segments:
        XCTAssertNil(segmentIntersection(between: s1, and: s5), "Segments should NOT meet")
    }
}
