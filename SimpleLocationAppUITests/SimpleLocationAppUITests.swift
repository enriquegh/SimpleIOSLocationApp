//
//  SimpleLocationAppUITests.swift
//  SimpleLocationAppUITests
//
//  Created by Enrique Gonzalez on 5/21/19.
//  Copyright © 2019 Enrique Gonzalez. All rights reserved.
//

import XCTest

class SimpleLocationAppUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        
        addUIInterruptionMonitor(withDescription: "Location Services") { (alert) -> Bool in
            alert.buttons["Allow"].tap()
            return true
        }
        
        XCUIApplication().tap() // need to interact with the app again for the handler to fire

        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let app = XCUIApplication()
        
        print(app.debugDescription)

        Thread.sleep(forTimeInterval: 5)
        
        let locationTextElement = app.otherElements["locationText"]
        
        let locationText = locationTextElement.value as! String
        
        XCTAssert("37.7873589, -122.408227" == locationText)
        
        
    }

}
