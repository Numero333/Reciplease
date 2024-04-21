//
//  SearchDetailModelTest.swift
//  RecipleaseTests
//
//  Created by François-Xavier on 16/04/2024.
//

import XCTest
import Foundation
@testable import Reciplease

final class SearchDetailModelTest: XCTestCase {
    
    private var recipes: EdamamSearch?
    private var model: SearchDetailModel!
    
    override func setUp() {
        super.setUp()
        let recipeDescription = RecipeDescription(label: "Test", image: "Image", url: "url", yield: 1, ingredientLines: ["Test"], totalTime: 1)
        model = SearchDetailModel(selectedRecipe: recipeDescription)
    }
    
    func testLoadDataWithNoRecipeStored() {
        //When
        model.loadData()
        sleep(UInt32(0.1))
        
        //Then
        XCTAssertFalse(self.model.likeState)
        XCTAssertLessThanOrEqual(self.model.recipe.count, 0)
        
    }
    
    func testSave() {
        //Given
        let expectation = self.expectation(description: "Save complete")
        
        // When
        model.handleFavoriteButton()
        
        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertTrue(self.model.likeState)
            XCTAssertGreaterThanOrEqual(self.model.recipe.count, 1)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 2, handler: nil)
    }
    
    func testDelete() {
        let saveExpectation = self.expectation(description: "Save complete")
        // Step 1: Add a recipe
        model.handleFavoriteButton()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertTrue(self.model.likeState)
            XCTAssertGreaterThanOrEqual(self.model.recipe.count, 1)
            saveExpectation.fulfill()
        }
        waitForExpectations(timeout: 2, handler: nil)
        
        // Step 2: Delete the recipe
        let deleteExpectation = self.expectation(description: "Delete complete")
        model.handleFavoriteButton()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertFalse(self.model.likeState)
            XCTAssertLessThanOrEqual(self.model.recipe.count, 0)
            deleteExpectation.fulfill()
        }
        waitForExpectations(timeout: 2, handler: nil)
    }

    func testDurationFormatted() {
        //Then
        XCTAssertEqual(model.selectedRecipe.durationFormatted, "0:1")
        
        //Given
        let fakeRecipe = EdamamSearch(results: [Recipe(recipe: RecipeDescription(label: "test", image: "test", url: "test", yield: 0, ingredientLines: ["coco"], totalTime: nil))])
        
        //Then
        XCTAssertEqual(fakeRecipe.results[0].recipe.durationFormatted, "N/A")
    }
}
