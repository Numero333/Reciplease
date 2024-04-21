//
//  CoreDataService.swift
//  Reciplease
//
//  Created by François-Xavier on 28/03/2024.
//

import CoreData

enum StorageType{
    case persistent, inMemory
}

class CoreDataService {
    
    //MARK: - Singleton
    static let shared: CoreDataService = CoreDataService()
    
    private var storageType: StorageType = .persistent
    
    // MARK: - Property
    var mainContext: NSManagedObjectContext
    var persistentContainer: NSPersistentContainer
    
    // MARK: - Initialization
    private init() {
        
        if ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil {
            storageType = .inMemory
        }
        
        guard let url = Bundle.main.url(forResource: "RecipeCoreDataModel", withExtension: "momd") else {
            fatalError("Error getting url of data model file")
        }
        guard let model = NSManagedObjectModel(contentsOf: url) else {
            fatalError("Error initializing model with URL")
        }
        
        persistentContainer = NSPersistentContainer(name: "RecipeCoreDataModel", managedObjectModel: model)
        
        if storageType == .inMemory {
            let description = NSPersistentStoreDescription()
            description.type = NSInMemoryStoreType
            self.persistentContainer.persistentStoreDescriptions = [description]
        }
        
        persistentContainer.loadPersistentStores { (_, error) in
            if let error = error {
                fatalError("Something went wrong while loading persistent store \(error)")
            }
        }
        
        mainContext = self.persistentContainer.viewContext
    }
    
    // MARK: - Accessible
    func read<T: NSManagedObject>(entityType: T.Type, context: NSManagedObjectContext, predicate: NSPredicate?, sortDescriptors: [NSSortDescriptor]?) async -> [T] {
        return await context.perform {
            let request: NSFetchRequest<T> = NSFetchRequest(entityName: String(describing: entityType))
            request.predicate = predicate
            request.sortDescriptors = sortDescriptors
            do {
                return try context.fetch(request)
            } catch {
                print("An error occurred during the reading operation: \(error)")
                return []
            }
        }
    }
    func save(context: NSManagedObjectContext) async {
        await context.perform {
            do {
                try context.save()
            } catch {
                print("An error occurred during the saving operation: \(error)")
            }
        }
    }
    func delete(objects: [NSManagedObject], context: NSManagedObjectContext) async {
        await context.perform {
            objects.forEach { context.delete($0) }
        }
    }
}
