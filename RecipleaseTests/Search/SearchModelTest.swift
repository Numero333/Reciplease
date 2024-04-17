//
//  SearchModelTest.swift
//  RecipleaseTests
//
//  Created by François-Xavier on 02/04/2024.
//

import XCTest
import Alamofire
@testable import Reciplease

final class SearchModelTest: XCTestCase {
    
    private let model = SearchModel()
    
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
    
    private var url: URL! =  URL(string: "test.com")
    
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
    
    func testLoadData() {
        //Given
        model.network = NetworkService(session: session)
        model.addIngredient(text: "tomatoes")
        //When
        model.loadData()
       
        //Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssert(self.model.recipes != nil)
        }
    }
}

private class MockSearchRecipeDelegate: SearchRecipeDelegate {
    
    var result: Bool?
    
    func didLoadData(result: Bool) {
        self.result = result
    }
}
