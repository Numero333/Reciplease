//
//  NetworkConfiguration.swift
//  Reciplease
//
//  Created by François-Xavier on 14/03/2024.
//

import Foundation
import Alamofire

struct APIConfiguration {
    
    let url: URLBuilder
    let parameters: RecipeQueryParameters
    let method: HTTPMethod
    
    enum URLBuilder {
        case edamamRecipe
        var value: URL {
            switch self {
            case .edamamRecipe:
                return URL(string: BaseUrl.edamam + Path.recipe)!
            }
        }
    }
}

enum BaseUrl {
    static let edamam = "https://api.edamam.com"
}

enum Path {
    static let recipe = "/api/recipes/v2"
}
