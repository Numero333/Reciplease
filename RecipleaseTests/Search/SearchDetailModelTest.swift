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
    
    var coreDataService: CoreDataService!
    var recipeDataStore: RecipeDataStore!
    
    var model: SearchDetailModel!
    
    private var data: Data! = {
        let bundle = Bundle(for: SearchDetailModelTest.self)
        let url = bundle.url(forResource: "MockRecipes", withExtension: "json")
        return try! Data(contentsOf: url!)
    }()
    
    var recipes: EdamamSearch?
    
    override func setUp() {
        super.setUp()
        coreDataService = CoreDataService(.inMemory)
        recipeDataStore = RecipeDataStore(mainContext: coreDataService.mainContext)
        recipes = try? JSONDecoder().decode(EdamamSearch.self, from: data)
        model = SearchDetailModel(selectedRecipe: recipes!.results[0].recipe)
    }
    
    
    // EXEMPLE FOR RECIPEDATASTORE
    
    func testLoadData() {
        //When
        model.loadData()
        
        //Then
        XCTAssertNotNil(model.recipe)
    }
    
    func testSave() {
        //When
        model.save()
        
        //Then
        XCTAssertNotNil(model.recipe)
    }
    
    func testDelete() {
        //When
        model.loadData()
        model.delete()
        
        //Then
        XCTAssert(model.recipe.isEmpty)
    }
    
    func testHandleLikeShouldBeTrue(){
        //When
        model.handleFavoriteButton()
         
        //Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertTrue(self.model.likeState)
        }
    }
    
    func testHandleLikeShouldBeFalse() {
        //When
        model.loadData()
        model.handleFavoriteButton()
        
        //Then
        XCTAssertFalse(model.likeState)
    }
    
    func testDurationFormatted() {
        //When
        XCTAssertEqual(model.selectedRecipe.durationFormatted, "0:10")
        
       let fakeRecipe = EdamamSearch(results: [Recipe(recipe: RecipeDescription(label: "test", image: "test", url: "test", yield: 0, ingredientLines: ["coco"], totalTime: nil))])
        
        XCTAssertEqual(fakeRecipe.results[0].recipe.durationFormatted, "N/A")
    }
    
    func testchichi() async {
        
        guard let recipesSelected = recipes?.results[0].recipe else {
            XCTFail("Expected not nil")
            return
        }
        
        recipeDataStore.save(selection: recipesSelected)
        
        let fetchedResult = try? await recipeDataStore.fetchRecipe(selection: recipesSelected.label, sortDescription: nil)
        
        XCTAssertNotNil(fetchedResult)
    }
    
    func testChocho() async {
        
        guard let recipesSelected = recipes?.results[0].recipe else {
            XCTFail("Expected not nil")
            return
        }
        
        recipeDataStore.save(selection: recipesSelected)
        let fetchedResult = try! await recipeDataStore.fetchRecipe(
            selection: recipesSelected.label,
            sortDescription: [NSSortDescriptor(
                key: "label",
                ascending: true
            )]
        )
        
        recipeDataStore.delete(recipe: fetchedResult)
        
    }
    
    func testfailt() async {
        
//        recipes = nil
//
//        recipeDataStore.save(selection: recipes!.results[0].recipe)
        
        let fetchedResult: [RecipeEntity]? = try! await recipeDataStore.fetchRecipe(selection: "Test Error", sortDescription: nil)
        
        
        XCTAssert(fetchedResult!.count < 1)
        
    }

}
