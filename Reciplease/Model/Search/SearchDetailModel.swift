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
    
<<<<<<< Updated upstream
    private func configureRecipeEntity(for newRecipe: RecipeEntity, recipe: RecipeDescription) {
        newRecipe.label = recipe.label
        newRecipe.ingredients = recipe.ingredientLines.joined(separator: " ")
        newRecipe.duration = recipe.durationFormatted
        newRecipe.image = recipe.image
        newRecipe.url = recipe.url
        newRecipe.yield = Int16(recipe.yield)
    }
=======
//    private func configureRecipeEntity(for newRecipe: RecipeEntity, recipe: RecipeDescription) {
//        newRecipe.label = recipe.label
//        newRecipe.ingredients = recipe.ingredientLines.joined(separator: " ")
//        newRecipe.duration = recipe.durationFormatted
//        newRecipe.image = recipe.image
//        newRecipe.url = recipe.url
//        newRecipe.yield = Int16(recipe.yield)
//    }
>>>>>>> Stashed changes
}










////
////  SearchDetailModel.swift
////  Reciplease
////
////  Created by François-Xavier on 27/03/2024.
////
//
//import Foundation
//import CoreData
//
//protocol SearchDetailDelegate: AnyObject {
//    func didUpdate(liked: Bool)
//}
//
//final class SearchDetailModel {
//
//    //MARK: - Property
//    private let coreDataService = CoreDataService.shared
//    private var likeState = false
//    private var recipe = [RecipeEntity]()
//    var selectedRecipe: RecipeDescription
//    weak var delegate: SearchDetailDelegate?
//
//    //MARK: - Initialization
//    init(selectedRecipe: RecipeDescription) {
//        self.selectedRecipe = selectedRecipe
//    }
//
//    //MARK: - Accessible
//    func loadData() {
//        Task {
//            let predicate = NSPredicate(format: "label == %@", selectedRecipe.label)
//            recipe = await self.coreDataService.read(entityType: RecipeEntity.self, context: self.coreDataService.mainContext, predicate: predicate, sortDescriptors: nil)
//            if !recipe.isEmpty {
//                delegate?.didUpdate(liked: true)
//                likeState.toggle()
//            }
//        }
//    }
//
//    func saveRecipeToDatabase() {
//        let context = coreDataService.mainContext
//        let newRecipe = RecipeEntity(context: context)
//        configureRecipeEntity(for: newRecipe, recipe: selectedRecipe)
//        Task {
//            await self.coreDataService.save(context: context)
//        }
//        loadData()
//    }
//
//    func handleFavoriteButton() {
//        likeState ? deleteRecipeFromDatabase() : saveRecipeToDatabase()
//    }
//
//    //MARK: - Private
//    private func deleteRecipeFromDatabase() {
//        Task {
//            await self.coreDataService.delete(objects: recipe, context: self.coreDataService.mainContext)
//            await self.coreDataService.save(context: self.coreDataService.mainContext)
//            recipe = []
//            if recipe.isEmpty {
//                delegate?.didUpdate(liked: false)
//                likeState.toggle()
//            }
//        }
//    }
//
//    private func configureRecipeEntity(for newRecipe: RecipeEntity, recipe: RecipeDescription) {
//        newRecipe.label = recipe.label
//        newRecipe.ingredients = recipe.ingredientLines.joined(separator: " ")
//        newRecipe.duration = recipe.durationFormatted
//        newRecipe.image = recipe.image
//        newRecipe.url = recipe.url
//        newRecipe.yield = Int16(recipe.yield)
//    }
//    }
