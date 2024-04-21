//
//  FavoriteListModelTest.swift
//  RecipleaseTests
//
//  Created by François-Xavier on 02/04/2024.
//

import XCTest
@testable import Reciplease

final class FavoriteListModelTest: XCTestCase {

    let recipeDataStore = RecipeDataStore()
    let model = FavoriteListModel()
    let recipe = RecipeDescription(label: "Test", image: "Test", url: "Test", yield: 1, ingredientLines: ["Test"], totalTime: 1)
        
    func testLoadData(){
        //Given
        let expectation = self.expectation(description: "Save complete")
        recipeDataStore.save(selection: recipe)
        
        //When
        model.loadData()
        
        //Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertNotNil(self.model.recipes)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 2, handler: nil)
    }
}
