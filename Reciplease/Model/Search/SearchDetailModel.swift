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
    let recipeDataStore = RecipeDataStore()
    private var likeState = false
    private var recipe = [RecipeEntity]()
    var selectedRecipe: RecipeDescription
    weak var delegate: SearchDetailDelegate?
    
    //MARK: - Initialization
    init(selectedRecipe: RecipeDescription) {
        self.selectedRecipe = selectedRecipe
    }
    
    //MARK: - Accessible
    func loadData() {
        Task {
            recipe = try await recipeDataStore.fetchRecipe(selection: selectedRecipe.label)
            checkIfLiked()
        }
    }
    
    func save() {
        recipeDataStore.save(selection: selectedRecipe)
        loadData()
    }
    
    func handleFavoriteButton() {
        likeState ? delete() : save()
    }
    
    //MARK: - Private
    private func delete() {
        recipeDataStore.delete(recipe: recipe)
        loadData()
    }
    
    private func checkIfLiked() {
        if !recipe.isEmpty {
            delegate?.didUpdate(liked: true)
            likeState = true
        } else {
            delegate?.didUpdate(liked: false)
            likeState = false
        }
    }
    
    private func configureRecipeEntity(for newRecipe: RecipeEntity, recipe: RecipeDescription) {
        newRecipe.label = recipe.label
        newRecipe.ingredients = recipe.ingredientLines.joined(separator: " ")
        newRecipe.duration = recipe.durationFormatted
        newRecipe.image = recipe.image
        newRecipe.url = recipe.url
        newRecipe.yield = Int16(recipe.yield)
    }
}
