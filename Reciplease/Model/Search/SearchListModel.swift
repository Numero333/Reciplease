//
//  SearchListModel.swift
//  Reciplease
//
//  Created by François-Xavier on 27/03/2024.
//

import Foundation

final class SearchListModel {
    
    //MARK: - Property
    private let network = NetworkService()
    var recipes: EdamamSearch?
    var selectedRecipe: RecipeDescription?
    
    //MARK: - Initialization
    init(recipes: EdamamSearch) {
        self.recipes = recipes
    }
}
