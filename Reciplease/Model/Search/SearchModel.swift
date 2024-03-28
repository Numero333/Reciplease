//
//  SearchModel.swift
//  Reciplease
//
//  Created by François-Xavier on 27/03/2024.
//

import Foundation

protocol SearchRecipeDelegate: AnyObject {
    func didLoadData(result: Bool)
}

final class SearchModel {
    
    //MARK: - Property
    private let network = NetworkService()
    var inputListIngredient = [String]()
    var listIngredientFormatted: String { return inputListIngredient.joined(separator: " ") }
    var recipes: EdamamSearch?
    weak var delegate: SearchRecipeDelegate?
    
    //MARK: - Accessible
    func addIngredient(text: String) {
        let textLowercased = text.lowercased()
        if !inputListIngredient.contains(textLowercased){
            inputListIngredient.append(textLowercased)
        }
    }
    
    func clearListIngredient() {
        inputListIngredient = []
    }
    
    func loadData() {
        Task {
            recipes = try await network.performRequest(apiRequest: APIConfiguration(url: .edamamRecipe, parameters: RecipeQueryParameters(query: listIngredientFormatted), method: .get))
            delegate?.didLoadData(result: true)
        }
    }
}
