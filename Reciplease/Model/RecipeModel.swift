//
//  RecipeModel.swift
//  Reciplease
//
//  Created by François-Xavier on 13/03/2024.
//

import Foundation

struct EdamamSearch: Decodable {
    let result: [Recipe]
    
    enum CodingKeys: String, CodingKey {
        case result = "hits"
    }
}

// MARK: - Recipe
struct Recipe: Decodable {
    let recipe: RecipeDescription
}

// MARK: - Recipe Description
struct RecipeDescription: Decodable {
    let label: String
    let image: String?
    let url: String
    let yield: Int
    let ingredientLines: [String]
    let totalTime: Int?
}
