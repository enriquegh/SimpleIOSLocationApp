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
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testMexicoLocation() {
        let SauceEUDefaultLocation = "52.535, 13.264"
        let SauceUSDefaultLocation = "37.78, -122.397"
        let SauceUSOtherDefaultLocation = "37.39, -121.962"
        let UITestDefaultLocation = "19.435, -99.136"
        
        let app = XCUIApplication()

        addUIInterruptionMonitor(withDescription: "Location Services") { (alert) -> Bool in
            let alertQuery = alert.buttons.matching(NSPredicate(format: "label BEGINSWITH %@", "Allow"))
            if (alertQuery.count > 0) {
                let alertElement = alertQuery.element(boundBy: 0)
                let isAlertPresent = alertElement.waitForExistence(timeout: 10)
                
                if (isAlertPresent) {
                    self.takeScreenshot()
                    alertElement.tap()
                }
            }
            return true
        }
        
        XCUIApplication().tap() // need to interact with the app again for the handler to fire
        
        
        // Uncomment to print Application's element hierarchy
        NSLog("\(app.debugDescription)")
//        sleep(10)
        var locationTextElement = app.otherElements["locationText"]
        
        // Needed for iOS 13 compatability
        if (!locationTextElement.exists) {
            locationTextElement = app.textViews.element(matching: NSPredicate(format: "identifier = %@", "locationText"))
            self.takeScreenshot()

        }
        XCTAssertTrue(locationTextElement.exists, "locationText does not exist")
        NSLog("\(locationTextElement.debugDescription)")
        var locationText = locationTextElement.value as! String
        
        //Take screenshot
        self.takeScreenshot()

        NSLog("SauceEUDefaultLocation: %@", SauceEUDefaultLocation)
        NSLog("SauceUSDefaultLocation %@", SauceUSDefaultLocation)
        NSLog("SauceUSOtherDefaultLocation %@", SauceUSOtherDefaultLocation)
        NSLog("UITestDefaultLocation %@", UITestDefaultLocation)
        
        var assertMessage = String(format: "Current Location %@ is not equal to expected locations.", locationText)
        var locationConditional = SauceEUDefaultLocation == locationText || SauceUSDefaultLocation == locationText || UITestDefaultLocation == locationText || SauceUSOtherDefaultLocation == locationText
        takeScreenshot()
        
        if (!locationConditional) { //Run everything again

                    addUIInterruptionMonitor(withDescription: "Location Services") { (alert) -> Bool in
                        let alertQuery = alert.buttons.matching(NSPredicate(format: "label BEGINSWITH %@", "Allow"))
                        if (alertQuery.count > 0) {
                            let alertElement = alertQuery.element(boundBy: 0)
                            let isAlertPresent = alertElement.waitForExistence(timeout: 10)
                            
                            if (isAlertPresent) {
                                self.takeScreenshot()
                                alertElement.tap()
                            }
                        }
                        return true
                    }
                    
                    XCUIApplication().tap() // need to interact with the app again for the handler to fire
                    
                    
                    // Uncomment to print Application's element hierarchy
                    NSLog("\(app.debugDescription)")
                    var locationTextElement = app.otherElements["locationText"]
                    
                    // Needed for iOS 13 compatability
                    if (!locationTextElement.exists) {
                        locationTextElement = app.textViews.element(matching: NSPredicate(format: "identifier = %@", "locationText"))
                        self.takeScreenshot()

                    }
                    XCTAssertTrue(locationTextElement.exists, "locationText does not exist")
                    NSLog("\(locationTextElement.debugDescription)")
                    locationText = locationTextElement.value as! String
                    
                    self.takeScreenshot()

                    NSLog("SauceEUDefaultLocation: %@", SauceEUDefaultLocation)
                    NSLog("SauceUSDefaultLocation %@", SauceUSDefaultLocation)
                    NSLog("SauceUSOtherDefaultLocation %@", SauceUSOtherDefaultLocation)
                    NSLog("UITestDefaultLocation %@", UITestDefaultLocation)
                    
                    assertMessage = String(format: "Current Location %@ is not equal to expected locations.", locationText)
                    locationConditional = SauceEUDefaultLocation == locationText || SauceUSDefaultLocation == locationText || UITestDefaultLocation == locationText || SauceUSOtherDefaultLocation == locationText
                    self.takeScreenshot()
        }
        
        
        XCTAssert(locationConditional, assertMessage)
        
        
    }
    
    func takeScreenshot() {
        let windowScreenshot = XCUIApplication().windows.firstMatch.screenshot()
        let screenshot = XCTAttachment(screenshot: windowScreenshot)
        screenshot.lifetime = .keepAlways
        add(screenshot)
    }

}
