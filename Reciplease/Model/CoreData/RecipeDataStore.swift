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
    private let coreDataService: CoreDataService
    private let mainContext: NSManagedObjectContext
    
    init(coreDataService: CoreDataService = CoreDataService()) {
        self.coreDataService = coreDataService
        self.mainContext = coreDataService.mainContext
    }
    
    //MARK: - Accessible
    func save(selection: RecipeDescription) {
        if let entityDescription = NSEntityDescription.entity(forEntityName: "RecipeEntity", in: mainContext) {
            let newRecipe = RecipeEntity(entity: entityDescription, insertInto: mainContext)
            configureRecipeEntity(for: newRecipe, recipe: selection)
            Task {
                await self.coreDataService.save(context: mainContext)
            }
        }
    }
    
    
    func fetchRecipe(selection: String?, sortDescription: [NSSortDescriptor]?) async -> [RecipeEntity]? {
        guard let selection = selection else { return [] }
        let sortDescriptor = NSSortDescriptor(key: "label", ascending: true)
        let predicate = NSPredicate(format: "label == %@", selection)
        let response = await self.coreDataService.read(entityType: RecipeEntity.self, context: mainContext, predicate: predicate, sortDescriptors: [sortDescriptor])
            return response
    }
    
    func fetchAllRecipe() async -> [RecipeEntity]? {
        let sortDescriptor = NSSortDescriptor(key: "label", ascending: true)
        let response = await self.coreDataService.read(entityType: RecipeEntity.self, context: mainContext, predicate: nil, sortDescriptors: [sortDescriptor])
            return response
        
    }
    
    func delete(recipe: [RecipeEntity]) {
        Task {
            await self.coreDataService.delete(objects: recipe, context: mainContext)
            await self.coreDataService.save(context: mainContext)
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
