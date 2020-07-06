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
    
    
    
    ///////////////////////////////////////////////////////////////
    //MARK: - API
    ///////////////////////////////////////////////////////////////
    
    /*
    * Function: Test retrieve transformer, exptected result should be error is nil and transformers is not nil
    * @param:
    * @return:
    */
    func testRetrieveTransformers() throws {
        
        var result : [TransformerObject]?
        var apiError : Error?
        let retrieveTransformerExpectation = expectation(description: "RetrieveTransformers")
        
        retrieveTransformers { (error, transformers) in
            result = transformers
            apiError = error
            retrieveTransformerExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 5) { (error) in
            XCTAssertNotNil(result)
            XCTAssertNil(apiError)
        }
    }
    
    /*
    * Function: Test adding transformer, exptected result should be error is nil and transformer is not nil
    * @param:
    * @return:
    */
    func testAddTransformer() throws {
        let newTransformer              = TransformerObject()
        newTransformer.name             = "Hoang"
        newTransformer.strength         = 10
        newTransformer.intelligence     = 10
        newTransformer.speed            = 5
        newTransformer.endurance        = 6
        newTransformer.rank             = 9
        newTransformer.courage          = 5
        newTransformer.firepower        = 6
        newTransformer.skill            = 10
        newTransformer.team             = "D"
        
        var result : TransformerObject?
        var apiError : Error?
        let addTransformerExpectation = expectation(description: "AddTransformer")
        createATransformer(transformer: newTransformer) { (error, addedTransformer) in
            result = addedTransformer
            apiError = error
            addTransformerExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 5) { (error) in
            XCTAssertNotNil(result)
            XCTAssertNil(apiError)
        }
    }
    
    /*
    * Function: Test delete transfomer object, exptected result should be error is not nil and successfully delete the newly created transformer
    * @param:
    * @return:
    */
    func testDeleteTransformer() throws {
        let newTransformer              = TransformerObject()
        newTransformer.name             = "Hoang"
        newTransformer.strength         = 10
        newTransformer.intelligence     = 10
        newTransformer.speed            = 5
        newTransformer.endurance        = 6
        newTransformer.rank             = 9
        newTransformer.courage          = 5
        newTransformer.firepower        = 6
        newTransformer.skill            = 10
        newTransformer.team             = "D"
        
        var result : Bool?
        var apiError : Error?
        let addTransformerExpectation = expectation(description: "AddTransformer")
        createATransformer(transformer: newTransformer) { (error, addedTransformer) in
            deleteTransformer(transformerID: addedTransformer!.id!) { (deleteError, isDeleted) in
                result = isDeleted
                apiError = deleteError
                addTransformerExpectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 8) { (error) in
            XCTAssertTrue(result!)
            XCTAssertNil(apiError)
        }
    }
    
    /*
    * Function: Test updating transformer object, exptected result should be error is nil and updated transformer is not nil
    * @param:
    * @return:
    */
    func testUpdateTransformer() throws {
        let newTransformer              = TransformerObject()
        newTransformer.name             = "Hoang"
        newTransformer.strength         = 10
        newTransformer.intelligence     = 10
        newTransformer.speed            = 5
        newTransformer.endurance        = 6
        newTransformer.rank             = 9
        newTransformer.courage          = 5
        newTransformer.firepower        = 6
        newTransformer.skill            = 10
        newTransformer.team             = "D"
        
        var result : TransformerObject?
        var apiError : Error?
        let updateTransformerExpectation = expectation(description: "AddTransformer")
        createATransformer(transformer: newTransformer) { (error, addedTransformer) in
            addedTransformer?.name = "updated transformer"
            updateTransformers(transformer: addedTransformer!) { (updatedError, updatedTransformer) in
                result = updatedTransformer
                apiError = updatedError
                updateTransformerExpectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 8) { (error) in
            XCTAssertNotNil(result)
            XCTAssertNil(apiError)
        }
    }

    
    ///////////////////////////////////////////////////////////////
    //MARK: - Utilities and logic
    ///////////////////////////////////////////////////////////////
    /*
    * Function: Test comparing 2 transformer objects, exptected result should be .Win
    * @param:
    * @return:
    */

    func testWinableCase1() throws {
        let newTransformer              = TransformerObject()
        newTransformer.name             = "Optimus Prime"
        newTransformer.strength         = 1
        newTransformer.intelligence     = 1
        newTransformer.speed            = 1
        newTransformer.endurance        = 1
        newTransformer.rank             = 1
        newTransformer.courage          = 1
        newTransformer.firepower        = 1
        newTransformer.skill            = 1
        newTransformer.team             = "D"
        
        
        let newTransformer2              = TransformerObject()
        newTransformer2.name             = "Hoang"
        newTransformer2.strength         = 10
        newTransformer2.intelligence     = 10
        newTransformer2.speed            = 10
        newTransformer2.endurance        = 10
        newTransformer2.rank             = 10
        newTransformer2.courage          = 10
        newTransformer2.firepower        = 10
        newTransformer2.skill            = 10
        newTransformer2.team             = "D"

        let result = newTransformer.isWinable(newTransformer2)
        XCTAssertEqual(result, .Win)
    }
    
    /*
    * Function: Test comparing 2 transformer objects, exptected result should be .tie
    * @param:
    * @return:
    */
    func testWinableCase2() throws {
        let newTransformer              = TransformerObject()
        newTransformer.name             = "Optimus Prime"
        newTransformer.strength         = 1
        newTransformer.intelligence     = 1
        newTransformer.speed            = 1
        newTransformer.endurance        = 1
        newTransformer.rank             = 1
        newTransformer.courage          = 1
        newTransformer.firepower        = 1
        newTransformer.skill            = 1
        newTransformer.team             = "D"
        
        
        let newTransformer2              = TransformerObject()
        newTransformer2.name             = "Optimus Prime"
        newTransformer2.strength         = 10
        newTransformer2.intelligence     = 10
        newTransformer2.speed            = 10
        newTransformer2.endurance        = 10
        newTransformer2.rank             = 10
        newTransformer2.courage          = 10
        newTransformer2.firepower        = 10
        newTransformer2.skill            = 10
        newTransformer2.team             = "D"

        let result = newTransformer.isWinable(newTransformer2)
        XCTAssertEqual(result, .Tie)
    }
    
    
    func testCompared2ArrayOfTransformers() throws {
        let newTransformer              = TransformerObject()
        newTransformer.name             = "William"
        newTransformer.strength         = 1
        newTransformer.intelligence     = 1
        newTransformer.speed            = 1
        newTransformer.endurance        = 1
        newTransformer.rank             = 1
        newTransformer.courage          = 1
        newTransformer.firepower        = 1
        newTransformer.skill            = 1
        newTransformer.team             = "D"
        
        let newTransformer2              = TransformerObject()
        newTransformer2.name             = "Henry"
        newTransformer2.strength         = 10
        newTransformer2.intelligence     = 10
        newTransformer2.speed            = 10
        newTransformer2.endurance        = 10
        newTransformer2.rank             = 10
        newTransformer2.courage          = 10
        newTransformer2.firepower        = 10
        newTransformer2.skill            = 10
        newTransformer2.team             = "D"
        
        let newTransformer3              = TransformerObject()
        newTransformer3.name             = "David"
        newTransformer3.strength         = 2
        newTransformer3.intelligence     = 2
        newTransformer3.speed            = 2
        newTransformer3.endurance        = 2
        newTransformer3.rank             = 2
        newTransformer3.courage          = 2
        newTransformer3.firepower        = 2
        newTransformer3.skill            = 2
        newTransformer3.team             = "A"
        
        let newTransformer4              = TransformerObject()
        newTransformer4.name             = "Aequilibrium"
        newTransformer4.strength         = 10
        newTransformer4.intelligence     = 10
        newTransformer4.speed            = 10
        newTransformer4.endurance        = 10
        newTransformer4.rank             = 10
        newTransformer4.courage          = 10
        newTransformer4.firepower        = 10
        newTransformer4.skill            = 10
        newTransformer4.team             = "A"
        
        let autobots = [newTransformer3, newTransformer4]
        let deceptions = [newTransformer,newTransformer2]
        
        let result = TransformerObject.battle(firstGroup: autobots, secondGroup: deceptions)
        
        XCTAssertEqual(result.0, .Win)
    }
    
}
