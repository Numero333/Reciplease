//
//  MockCoreDataService.swift
//  RecipleaseTests
//
//  Created by François-Xavier on 22/04/2024.
//

import Foundation
import Reciplease
import CoreData


class MockCoreDataService: CoreDataService {
    
    override init() {
        super.init()
        persistentContainer = NSPersistentContainer(name: "RecipeCoreDataModel")
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        description.shouldAddStoreAsynchronously = false
        self.persistentContainer.persistentStoreDescriptions = [description]
        self.persistentContainer.loadPersistentStores { (_, error) in
            if let error = error {
                print("Error loading in-memory persistent store: \(error)")
            }
        }
        mainContext = self.persistentContainer.viewContext
    }
}
