//
//  NetworkServiceTest.swift
//  RecipleaseTests
//
//  Created by François-Xavier on 13/04/2024.
//

import XCTest
import Alamofire
@testable import Reciplease

final class NetworkServiceTest: XCTestCase {
    
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
    
    var recipes: EdamamSearch?
    
    func testAPIRequestWithCorrectResponse() async {
        
        // Given
        SessionFakeProtocol.loadingData = {
            let response = HTTPURLResponse(url: self.url, statusCode: 200, httpVersion: nil, headerFields: nil)
            return (response!, self.data)
        }
        
        // When
        recipes = try? await NetworkService(session: session).performRequest(apiRequest: APIConfiguration(url: .edamamRecipe, parameters: RecipeQueryParameters(query: "tomatoes"), method: .get))
        
        // Then
        XCTAssert((recipes?.results.count)! > 0)
    }
    
}
