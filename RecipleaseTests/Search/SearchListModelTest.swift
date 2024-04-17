//
//  SearchListModelTest.swift
//  RecipleaseTests
//
//  Created by François-Xavier on 15/04/2024.
//

import XCTest
import Alamofire
@testable import Reciplease

final class SearchListModelTest: XCTestCase {
    
    private var session: Session! = {
        let configuration = URLSessionConfiguration.af.default
        configuration.protocolClasses = [SessionFakeProtocol.self]
        return Alamofire.Session(configuration: configuration)
    }()
    
    private var data: Data! = {
        let bundle = Bundle(for: NetworkServiceTest.self)
        let url = bundle.url(forResource: "MockRecipes", withExtension: "json")
        return try! Data(contentsOf: url!)
    }()
    
    private var url: URL! =  URL(string: "ok")
    
    var recipes: EdamamSearch?
    
    func testInitWithRecipes() async {
        
        //Given
        let ingredients = "tomatoes"
        let recipes: EdamamSearch?
        
        //When
        recipes = try? await NetworkService(session: session).performRequest(apiRequest: APIConfiguration(url: .edamamRecipe, parameters: RecipeQueryParameters(query: ingredients), method: .get))
        
        guard let recipesUnwrapped = recipes else {
            XCTFail("Expected non-nil value, but got nil")
            return
        }
        
        //Then
        let model = SearchListModel(recipes: recipesUnwrapped)
        XCTAssertGreaterThanOrEqual(model.recipes!.results.count, 1)
    }
    
}
