//
//  CoreDataServiceTest.swift
//  RecipleaseTests
//
//  Created by François-Xavier on 02/04/2024.
//

import CoreData
@testable import Reciplease

//struct CoreDataServiceTest {
//    
//    // MARK: - Property
//    let mainContext: NSManagedObjectContext
//    let persistentContainer: NSPersistentContainer
//    
//    //MARK: - Initialization
//    init() {
////        guard let url = Bundle.main.url(forResource: "RecipeCoreDataModel", withExtension: "momd") else {
////            fatalError("Something went wrong")
////        }
////        guard let model = NSManagedObjectModel(contentsOf: url) else {
////            fatalError("Something went wrong")
////        }
//        
//        persistentContainer = NSPersistentContainer(name: "RecipeCoreDataModel")
//        let description = NSPersistentStoreDescription()
////        let description = persistentContainer.persistentStoreDescriptions.first
//        description.type = NSInMemoryStoreType
//        persistentContainer.persistentStoreDescriptions = [description]
//        persistentContainer.loadPersistentStores { (_, error) in
//            if let error {
//                fatalError("Something went wrong \(error)")
//            }
//        }
//        mainContext = self.persistentContainer.viewContext
//    }
//}
