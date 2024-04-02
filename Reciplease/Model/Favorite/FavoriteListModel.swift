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
    private let coreDataService = CoreDataService.shared
    var recipes: [RecipeEntity]?
    var selectedRecipe: RecipeEntity?
    weak var delegate: FavoriteListDelegate?
    
    //MARK: - Initialization
    init() {
        loadData()
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
        let data = await self.coreDataService.read(entityType: RecipeEntity.self, context: self.coreDataService.mainContext, predicate: nil, sortDescriptors: nil)
        return data
    }
}
