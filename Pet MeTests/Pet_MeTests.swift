//
//  Pet_MeTests.swift
//  Pet MeTests
//
//  Created by Газияв Исхаков on 07.01.2020.
//  Copyright © 2020 Газияв Исхаков. All rights reserved.
//

import XCTest
@testable import Pet_Me

class Pet_MeTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testWindowRootViewControllerEqualMainViewController() {
        let window = UIWindow()
        let vc = HomeViewController()
        window.rootViewController = vc
        XCTAssertEqual(window.rootViewController, vc)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
