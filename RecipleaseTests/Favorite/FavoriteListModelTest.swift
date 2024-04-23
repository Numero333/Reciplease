//
//  FavoriteListModelTest.swift
//  RecipleaseTests
//
//  Created by François-Xavier on 02/04/2024.
//

import XCTest
@testable import Reciplease

final class FavoriteListModelTest: XCTestCase {
    
    var model: FavoriteListModel!
    let recipeDataStore = RecipeDataStore(coreDataService: MockCoreDataService())
    let recipe = RecipeDescription(label: "Test", image: "Test", url: "Test", yield: 1, ingredientLines: ["Test"], totalTime: 1)
    
    override func setUp() {
        model = FavoriteListModel(recipeDataStore: recipeDataStore)
    }
        
    func testLoadData(){
        //Given
        let expectation = self.expectation(description: "Save complete")
        recipeDataStore.save(selection: recipe)
        
        //When
        model.loadData()
        
        //Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertEqual(self.model.recipes![0].label, "Test")
            expectation.fulfill()
        }
        waitForExpectations(timeout: 2, handler: nil)
    }
    
    func testLoadDataWithNoData(){
        //Given
        let expectation = self.expectation(description: "Save complete")
        
        //When
        model.loadData()
        
        //Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertLessThanOrEqual(self.model.recipes!.count, 0)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 2, handler: nil)
    }
}
