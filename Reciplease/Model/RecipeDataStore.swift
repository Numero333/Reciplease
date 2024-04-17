//
//  RecipeDataStore.swift
//  Reciplease
//
//  Created by François-Xavier on 11/04/2024.
//

import Foundation
import CoreData

final class RecipeDataStore {
    
    //MARK: - Properties
    private let coreDataService = CoreDataService.shared
    
    let mainContext: NSManagedObjectContext
    
    init(mainContext: NSManagedObjectContext = CoreDataService.shared.mainContext) {
        self.mainContext = mainContext
    }
    
    //MARK: - Accessible
    func save(selection: RecipeDescription) {
        let newRecipe = RecipeEntity(context: self.coreDataService.mainContext)
        configureRecipeEntity(for: newRecipe, recipe: selection)
        Task {
            try await self.coreDataService.save(context: self.coreDataService.mainContext)
        }
    }
    
    func fetchRecipe(selection: String?, sortDescription: [NSSortDescriptor]?) async -> [RecipeEntity] {
        guard let selection = selection else { return [] }
        let sortDescriptor = NSSortDescriptor(key: "label", ascending: true)
        let predicate = NSPredicate(format: "label == %@", selection)
        let response = await self.coreDataService.read(entityType: RecipeEntity.self, context: self.coreDataService.mainContext, predicate: predicate, sortDescriptors: [sortDescriptor])
        return response
    }
    
    func fetchAllRecipe() async -> [RecipeEntity] {
        let sortDescriptor = NSSortDescriptor(key: "label", ascending: true)
        let response = await self.coreDataService.read(entityType: RecipeEntity.self, context: self.coreDataService.mainContext, predicate: nil, sortDescriptors: [sortDescriptor])
        return response
    }
    
    func delete(recipe: [RecipeEntity]) {
        Task {
            await self.coreDataService.delete(objects: recipe, context: self.coreDataService.mainContext)
            try await self.coreDataService.save(context: self.coreDataService.mainContext)
        }
    }
    
    private func configureRecipeEntity(for newRecipe: RecipeEntity, recipe: RecipeDescription) {
        newRecipe.label = recipe.label
        newRecipe.ingredients = recipe.ingredientLines.joined(separator: "\n")
        newRecipe.duration = recipe.durationFormatted
        newRecipe.image = recipe.image
        newRecipe.url = recipe.url
        newRecipe.yield = Int16(recipe.yield)
    }
}
