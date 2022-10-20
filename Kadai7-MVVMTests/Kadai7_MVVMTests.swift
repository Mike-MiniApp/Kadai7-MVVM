//
//  Kadai7_MVVMTests.swift
//  Kadai7-MVVMTests
//
//  Created by 近藤米功 on 2022/10/19.
//

import XCTest
@testable import Kadai7_MVVM

final class Kadai7_MVVMTests: XCTestCase {

    let calculator = Calculator()

    func 足し算() {
        XCTAssertEqual(calculator.addition(number1: 1, number2: 1), 2)
    }

    func 引き算() {
        XCTAssertEqual(calculator.addition(number1: 1, number2: 1), 0)
    }


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

}
