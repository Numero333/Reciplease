//
//  SearchListModelTest.swift
//  RecipleaseTests
//
//  Created by François-Xavier on 15/04/2024.
//

import XCTest
import Alamofire
@testable import Reciplease

final class SearchListModelTests: XCTestCase {
    
    private var mockRecipes: EdamamSearch!

    override func setUp() {
        super.setUp()
        let recipeDescription = RecipeDescription(label: "Test", image: "Test", url: "test.com", yield: 1, ingredientLines: ["Test"], totalTime: 1)
        let recipe = Recipe(recipe: recipeDescription)
        mockRecipes = EdamamSearch(results: [recipe])
    }

    func testInitWithRecipes() {
        
        // When
        let model = SearchListModel(recipes: mockRecipes)
        
        // Then
        XCTAssertNotNil(model.recipes)
        XCTAssertEqual(model.recipes?.results.count, 1)
    }
    
}
