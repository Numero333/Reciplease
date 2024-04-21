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
    private var searchModel: SearchDetailModel!
    
    override func setUp() {
        super.setUp()
        searchModel = SearchDetailModel(selectedRecipe: RecipeDescription(label: "Test", image: "Image", url: "url", yield: 1, ingredientLines: ["Test"], totalTime: 1))
    }
    
    func testListOfIngredient() {
        let expectation = self.expectation(description: "Save complete")
        
        // When
        searchModel.handleFavoriteButton()
        
        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertTrue(self.searchModel.likeState)
            XCTAssertGreaterThanOrEqual(self.searchModel.recipe.count, 1)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 2, handler: nil)
        let model = FavoriteDetailModel(recipe: searchModel.recipe[0])
        
        XCTAssert(model.ingredients == ["Test"])

    }
    
    
    
    func testSave() {
        let expectation = self.expectation(description: "Save complete")
        
        // When
        searchModel.handleFavoriteButton()
        
        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertTrue(self.searchModel.likeState)
            XCTAssertGreaterThanOrEqual(self.searchModel.recipe.count, 1)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 2, handler: nil)
        let model = FavoriteDetailModel(recipe: searchModel.recipe[0])
        let expectation2 = self.expectation(description: "delete complete")
        model.delete()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            print(model.recipe)
//            XCTAssertNotIdentical(model.recipe, self.searchModel.recipe[0])
            XCTAssert(model.ingredients.isEmpty)
            expectation2.fulfill()
        }
        waitForExpectations(timeout: 2, handler: nil)
        
    }

}
