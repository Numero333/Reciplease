//
//  SearchModelTest.swift
//  RecipleaseTests
//
//  Created by François-Xavier on 02/04/2024.
//

import XCTest
import Alamofire
@testable import Reciplease

final class SearchModelTest: XCTestCase {
    
    private let model = SearchModel()
    private var session: Session! = {
        let configuration = URLSessionConfiguration.af.default
        configuration.protocolClasses = [SessionFakeProtocol.self]
        return Alamofire.Session(configuration: configuration)
    }()
        
    
    func testAddIngredient() {
        //Given
        model.addIngredient(text: "tomato")
        
        //Then
        XCTAssertEqual(model.inputListIngredient, ["tomato"])
    }
    
    func testListIngredientFormatted() {
        //Given
        model.addIngredient(text: "tomato")
        
        //Then
        XCTAssertEqual(model.listIngredientFormatted, "tomato")
    }
    
    func testClearListIngredient() {
        //Given
        model.addIngredient(text: "tomato")
        
        //When
        model.clearListIngredient()
        
        //Then
        XCTAssertEqual(model.inputListIngredient, [])
        XCTAssertEqual(model.listIngredientFormatted, "")
    }
    
    func testLoadData() {
        //Given
        let expectation = self.expectation(description: "Load Data complete")
        model.network = NetworkService(session: session)
        model.addIngredient(text: "tomatoes")
        
        //When
        model.loadData()
       
        //Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssert(self.model.recipes != nil)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 2, handler: nil)
    }
}

private class MockSearchRecipeDelegate: SearchRecipeDelegate {
    
    var result: Bool?
    
    func didLoadData(result: Bool) {
        self.result = result
    }
}
