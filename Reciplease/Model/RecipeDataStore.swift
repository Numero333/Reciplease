//
//  RecipeDataStore.swift
//  Reciplease
//
//  Created by François-Xavier on 11/04/2024.
//

import Foundation

class RecipeDataStore {
    
    //MARK: - Properties
    private let coreDataService = CoreDataService.shared
    
    //MARK: - Accessible
    
    // CREATE
    func save(selection: RecipeDescription) {
        let newRecipe = RecipeEntity(context: self.coreDataService.mainContext)
        configureRecipeEntity(for: newRecipe, recipe: selection)
        Task {
            try await self.coreDataService.save(context: self.coreDataService.mainContext)
        }
    }
    
    // READ
    func fetchRecipe(selection: String) async throws -> [RecipeEntity] {
        let predicate = NSPredicate(format: "label == %@", selection)
        let response = await self.coreDataService.read(entityType: RecipeEntity.self, context: self.coreDataService.mainContext, predicate: predicate, sortDescriptors: nil)
        return response
    }
    
    // DELETE
    func delete(recipe: [RecipeEntity]) {
        Task {
            await self.coreDataService.delete(objects: recipe, context: self.coreDataService.mainContext)
            try await self.coreDataService.save(context: self.coreDataService.mainContext)
        }
    }
    
    private func configureRecipeEntity(for newRecipe: RecipeEntity, recipe: RecipeDescription) {
        newRecipe.label = recipe.label
        newRecipe.ingredients = recipe.ingredientLines.joined(separator: "newLine")
        newRecipe.duration = recipe.durationFormatted
        newRecipe.image = recipe.image
        newRecipe.url = recipe.url
        newRecipe.yield = Int16(recipe.yield)
    }
}
