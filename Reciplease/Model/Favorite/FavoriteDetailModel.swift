//
//  FavoriteDetailModel.swift
//  Reciplease
//
//  Created by François-Xavier on 01/04/2024.
//

import Foundation

protocol FavoriteDetailDelegate: AnyObject {
    func didUpdate(liked: Bool)
}

final class FavoriteDetailModel {
    
    //MARK: - Property
    private let recipeDataStore: RecipeDataStore
    let recipe: RecipeEntity
    var ingredients: [String] {
        formattedIngredient(recipe: recipe)
    }
    weak var delegate: FavoriteDetailDelegate?
    
    //MARK: - Initialization
    init(recipe: RecipeEntity, recipeDataStore: RecipeDataStore) {
        self.recipe = recipe
        self.recipeDataStore = recipeDataStore
    }
    
    //MARK: - Accesible
    func delete() {
        recipeDataStore.delete(recipe: [recipe])
        delegate?.didUpdate(liked: false)
    }
    
    //MARK: - Private
    private func formattedIngredient(recipe: RecipeEntity) -> [String] {
        var ingredients = [String]()
        let formattedIngredients = recipe.ingredients?.components(separatedBy: "\n").filter { !$0.isEmpty }
        if let formattedIngredients = formattedIngredients {
            ingredients.append(contentsOf: formattedIngredients)
        }
        return ingredients
    }
}
