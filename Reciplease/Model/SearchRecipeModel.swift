//
//  SearchRecipeModel.swift
//  Reciplease
//
//  Created by François-Xavier on 25/03/2024.
//

import Foundation

class SearchRecipeModel {
    
    //MARK: - Property
    let network = NetworkService()
    
    var inputListIngredient = [String]()
    var listIngredientFormatted: String {
        return inputListIngredient.joined(separator: " ")
    }
    
    var recipes: EdamamSearch?
    var selectedRecipe: RecipeDescription?
    
    //MARK: - Accesible
    func addIngredient(text: String) {
        inputListIngredient.append(text)
    }
    
    func clearListIngredient() {
        inputListIngredient = []
    }
    
    func loadData() {
        print(listIngredientFormatted)
        Task {
            recipes = try await network.performRequest(apiRequest: APIConfiguration(url: .edamamRecipe, parameters: RecipeQueryParameters(query: listIngredientFormatted), method: .get))
        }
    }
}
