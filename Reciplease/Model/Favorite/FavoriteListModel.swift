//
//  FavoriteListModel.swift
//  Reciplease
//
//  Created by François-Xavier on 31/03/2024.
//

import Foundation

protocol FavoriteListDelegate: AnyObject {
    func didLoadData(result: Bool)
}

final class FavoriteListModel {
    
    //MARK: - Property
    let recipeDataStore: RecipeDataStore
    var recipes: [RecipeEntity]?
    var selectedRecipe: RecipeEntity?
    weak var delegate: FavoriteListDelegate?
    
    //MARK: - Initialization
    init(recipeDataStore: RecipeDataStore = RecipeDataStore()) {
        self.recipeDataStore = recipeDataStore
    }
    
    //MARK: - Accesible
    func loadData() {
        Task {
            recipes = await fetchDatabase()
            delegate?.didLoadData(result: true)
        }
    }
    
    //MARK: - Private
    private func fetchDatabase() async -> [RecipeEntity] {
        var fetchedRecipes = [RecipeEntity]()
        let fetchedData = await recipeDataStore.fetchAllRecipe()
        if let fetchedData = fetchedData {
            fetchedRecipes.append(contentsOf: fetchedData)
        }
        return fetchedRecipes
    }
}
