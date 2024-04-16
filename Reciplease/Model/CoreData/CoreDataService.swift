//
//  CoreDataService.swift
//  Reciplease
//
//  Created by François-Xavier on 28/03/2024.
//

import CoreData

protocol CoreDataServiceInterface: AnyObject {
    var mainContext: NSManagedObjectContext { get }
    func save(context: NSManagedObjectContext) async throws
    func read<T: NSManagedObject>(entityType: T.Type, context: NSManagedObjectContext, predicate: NSPredicate?, sortDescriptors: [NSSortDescriptor]?) async -> [T]
    func delete(objects: [NSManagedObject], context: NSManagedObjectContext) async
}

final class CoreDataService: CoreDataServiceInterface {
    
    //MARK: - Singleton
    static let shared: CoreDataServiceInterface = CoreDataService()
    
    // MARK: - Property
    let mainContext: NSManagedObjectContext
    let persistentContainer: NSPersistentContainer
    
    // MARK: - Initialization
    private init() {
        guard let url = Bundle.main.url(forResource: "RecipeCoreDataModel", withExtension: "momd") else {
            fatalError("Something went wrong")
        }
        guard let model = NSManagedObjectModel(contentsOf: url) else {
            fatalError("Something went wrong")
        }
        
        persistentContainer = NSPersistentContainer(name: "RecipeCoreDataModel", managedObjectModel: model)
        persistentContainer.loadPersistentStores { (_, error) in
            if let error {
                fatalError("Something went wrong \(error)")
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
