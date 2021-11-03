//
//  DetailedViewControllerTestFile.swift
//  ShoppingCartTests
//
//  Created by VinayKiran M on 03/11/21.
//

import XCTest
import UIKit

class DetailedViewControllerTestFile: XCTestCase {

    let aDetailedViewController = DetailedViewController()
    var asset =  Asset(id: "1", name: "Test", image: "image.com", description: "test Data", price: "45.6")
    
    override func setUp() {
        super.setUp()
        aDetailedViewController.asset = asset
    }
    
    
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testIsAddedToCart() {
        XCTAssertFalse(aDetailedViewController.isAddedToCart())
    }
    
    func testAddToCart() {
        aDetailedViewController.addToCartAction("")
        
        XCTAssertFalse(aDetailedViewController.isAddedToCart())
    }
    
    func testButtonTitle() {
        let title = aDetailedViewController.getButtonTitle()
        XCTAssertEqual(title, "Add To Cart")
    }

}
