//
//  FavoriteDetailModel.swift
//  Reciplease
//
//  Created by François-Xavier on 01/04/2024.
//

import Foundation

final class FavoriteDetailModel {
    
    //MARK: - Property
    let recipe: RecipeEntity
    var ingredients: [String] {
        recipe.ingredients?.components(separatedBy: " ").filter { !$0.isEmpty } ?? []
    }
    
    //MARK: - Initialization
    init(recipe: RecipeEntity) {
        self.recipe = recipe
    }
}
