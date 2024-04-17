//
//  FavoriteListModelTest.swift
//  RecipleaseTests
//
//  Created by François-Xavier on 02/04/2024.
//

import XCTest
@testable import Reciplease

final class FavoriteListModelTest: XCTestCase {

    var coreDataService: CoreDataService!
    var recipeDataStore: RecipeDataStore!
    
    var model = FavoriteListModel()
    
    private var data: Data! = {
        let bundle = Bundle(for: SearchDetailModelTest.self)
        let url = bundle.url(forResource: "MockRecipes", withExtension: "json")
        return try! Data(contentsOf: url!)
    }()
    
    var recipes: EdamamSearch?
    
    override func setUp() {
        super.setUp()
        coreDataService = CoreDataService()
        recipeDataStore = RecipeDataStore()
        recipes = try? JSONDecoder().decode(EdamamSearch.self, from: data)
    }
    
    func testLoadData(){
        //Given
        recipeDataStore.save(selection: recipes!.results[0].recipe)
        
        //When
        model.loadData()
        
        //Then
        XCTAssertNotNil(model.recipes)
    }

}
