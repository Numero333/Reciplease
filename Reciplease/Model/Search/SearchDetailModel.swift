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
    var likeState = false
    var recipe = [RecipeEntity]()
    let selectedRecipe: RecipeDescription
    weak var delegate: SearchDetailDelegate?
        
    //MARK: - Initialization
    init(selectedRecipe: RecipeDescription) {
        self.selectedRecipe = selectedRecipe
    }
    
    //MARK: - Accessible
    func loadData() {
        Task {
            recipe = await recipeDataStore.fetchRecipe(selection: selectedRecipe.label, sortDescription: nil)
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
        loadData()
    }
    
    private func setLikeState() {
        if !recipe.isEmpty {
            delegate?.didUpdate(liked: true)
            likeState = true
        } else {
            delegate?.didUpdate(liked: false)
            likeState = false
        }
    }
}
