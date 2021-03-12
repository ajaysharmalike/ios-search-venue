//
//  AlertTestClass.swift
//  VenueSearchTests
//
//  Created by Ajay Sharma on 12/03/21.
//  Copyright © 2021 TTN. All rights reserved.
//

import XCTest
@testable import VenueSearch

class AlertTestClass: XCTestCase {

    var sut: VenueSearchViewController!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "VenueSearchViewController") as? VenueSearchViewController
        let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as! SceneDelegate
        sceneDelegate.window?.rootViewController = sut
    }
   
    func testAlert() {
        XCTAssertNoThrow(sut.showAlert(title: "Alert", message: "Some message", actionTexts: ["OK"]) { (clickedIndex) in })
        XCTAssertTrue(sut.presentedViewController is UIAlertController)
        XCTAssertEqual(sut.presentedViewController?.title, "Alert")
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

}

