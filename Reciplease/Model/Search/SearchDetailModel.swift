//
//  SearchDetailModel.swift
//  Reciplease
//
//  Created by François-Xavier on 27/03/2024.
//

import Foundation
import CoreData

protocol SearchDetailDelegate: AnyObject {
    func didUpdate(liked: Bool)
}

final class SearchDetailModel {
    
    //MARK: - Property
    private let recipeDataStore: RecipeDataStore
    let selectedRecipe: RecipeDescription
    var likeState = false
    var recipe = [RecipeEntity]()
    weak var delegate: SearchDetailDelegate?
        
    //MARK: - Initialization
    init(selectedRecipe: RecipeDescription, recipeDataStore: RecipeDataStore = RecipeDataStore()) {
        self.selectedRecipe = selectedRecipe
        self.recipeDataStore = recipeDataStore
    }
    
    //MARK: - Accessible
    func loadData() {
        Task {
            let fetchedRecipes = await recipeDataStore.fetchRecipe(selection: selectedRecipe.label, sortDescription: nil)
            if let fetchedRecipes = fetchedRecipes {
                recipe.append(contentsOf: fetchedRecipes)
            }
            setLikeState()
        }
    }
    
    func handleFavoriteButton() {
        likeState ? delete() : save()
    }
    
    //MARK: - Private
    private func save() {
        recipeDataStore.save(selection: selectedRecipe)
        loadData()
    }
    
    private func delete() {
        recipeDataStore.delete(recipe: recipe)
        recipe = []
        loadData()
    }
    
    private func setLikeState() {
        if recipe.count > 0 {
            delegate?.didUpdate(liked: true)
            likeState = true
        } else {
            delegate?.didUpdate(liked: false)
            likeState = false
        }
    }
}
