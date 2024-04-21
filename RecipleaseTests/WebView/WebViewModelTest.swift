//
//  WebViewModelTest.swift
//  RecipleaseTests
//
//  Created by François-Xavier on 20/04/2024.
//

import XCTest
@testable import Reciplease

final class WebViewModelTest: XCTestCase {

    private var model: WebViewModel!
    
    override func setUp() {
        super.setUp()
        model = WebViewModel(url: "test.com")
    }
    
    func testUrlShouldNotBeNil() {
        //Then
        XCTAssert(model.url == "test.com")
    }

}
