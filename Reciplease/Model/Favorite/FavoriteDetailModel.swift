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
    let recipe: RecipeEntity
    let recipeDataStore = RecipeDataStore()
    var ingredients: [String] {
        recipe.ingredients?.components(separatedBy: "\n").filter { !$0.isEmpty } ?? []
    }
    weak var delegate: FavoriteDetailDelegate?
    
    //MARK: - Initialization
    init(recipe: RecipeEntity) {
        self.recipe = recipe
    }
    
    //MARK: - Accesible
    func delete() {
        recipeDataStore.delete(recipe: [recipe])
        delegate?.didUpdate(liked: false)
    }
}
