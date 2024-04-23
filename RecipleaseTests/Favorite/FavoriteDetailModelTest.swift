//
//  FavoriteDetailModelTest.swift
//  RecipleaseTests
//
//  Created by François-Xavier on 02/04/2024.
//

import XCTest
@testable import Reciplease


final class FavoriteDetailModelTest: XCTestCase {

    private var recipes: EdamamSearch?
    
    func testListOfIngredient() {
        //Given
        let expectation = self.expectation(description: "Save complete")
        let searchModel = SearchDetailModel(selectedRecipe: RecipeDescription(label: "Test", image: "Image", url: "url", yield: 1, ingredientLines: ["Test"], totalTime: 1),recipeDataStore: RecipeDataStore(coreDataService: MockCoreDataService()))
        
        // When
        searchModel.handleFavoriteButton()
        
        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertTrue(searchModel.likeState)
            XCTAssertGreaterThanOrEqual(searchModel.recipe.count, 1)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 2, handler: nil)
        let model = FavoriteDetailModel(recipe: searchModel.recipe[0], recipeDataStore: RecipeDataStore(coreDataService: MockCoreDataService()))
        
        XCTAssert(model.ingredients == ["Test"])

    }
    
    func testListOfIngredientIsEmpty() {
        //Given
        let expectation = self.expectation(description: "Save complete")
        let searchModel = SearchDetailModel(selectedRecipe: RecipeDescription(label: "Test", image: "Image", url: "url", yield: 1, ingredientLines: [], totalTime: 1),recipeDataStore: RecipeDataStore(coreDataService: MockCoreDataService()))
        
        // When
        searchModel.handleFavoriteButton()
        
        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertTrue(searchModel.likeState)
            XCTAssertGreaterThanOrEqual(searchModel.recipe.count, 1)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 2, handler: nil)
        
        let model = FavoriteDetailModel(recipe: searchModel.recipe[0], recipeDataStore: RecipeDataStore(coreDataService: MockCoreDataService()))
        XCTAssert(model.ingredients == [])
    }
    
    
    
    func testSave() {
        //Given
        let expectation = self.expectation(description: "Save complete")
        let recipeDataStore = RecipeDataStore(coreDataService: MockCoreDataService())
        let searchModel = SearchDetailModel(selectedRecipe: RecipeDescription(label: "Test", image: "Image", url: "url", yield: 1, ingredientLines: ["Test"], totalTime: 1),recipeDataStore: recipeDataStore)
        
        // When
        searchModel.handleFavoriteButton()
        
        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertTrue(searchModel.likeState)
            XCTAssertGreaterThanOrEqual(searchModel.recipe.count, 1)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 2, handler: nil)
        let model = FavoriteDetailModel(recipe: searchModel.recipe[0], recipeDataStore: recipeDataStore)
        let expectation2 = self.expectation(description: "delete complete")
        model.delete()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssert(model.ingredients.isEmpty)
            expectation2.fulfill()
        }
        waitForExpectations(timeout: 2, handler: nil)
    }
}
