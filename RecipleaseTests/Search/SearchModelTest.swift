//
//  SearchModelTest.swift
//  RecipleaseTests
//
//  Created by François-Xavier on 02/04/2024.
//

import XCTest
@testable import Reciplease

final class SearchModelTest: XCTestCase {
    
    private let model = SearchModel()
    
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
    
    

}

private class MockSearchRecipeDelegate: SearchRecipeDelegate {
    
    var result: Bool?
    
    func didLoadData(result: Bool) {
        self.result = result
    }
}
