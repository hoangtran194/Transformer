//
//  TransformerTests.swift
//  TransformerTests
//
//  Created by Hoang Tran on 2020-07-02.
//  Copyright © 2020 Hoang Tran. All rights reserved.
//

import XCTest
@testable import Transformer

class TransformerTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let newTransformer = TransformerObject()
        newTransformer.name = "Hoang"
        newTransformer.strength = 10
        newTransformer.intelligence = 10
        newTransformer.speed = 5
        newTransformer.endurance = 6
        newTransformer.rank = 9
        newTransformer.courage = 5
        newTransformer.firepower = 6
        newTransformer.skill  = 10
        newTransformer.team = "D"
        
        createATransformer(transformer: newTransformer) { (error, addedTransformer) in
            print("abc")            
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
