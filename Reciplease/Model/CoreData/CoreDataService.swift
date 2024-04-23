//
//  CoreDataService.swift
//  Reciplease
//
//  Created by François-Xavier on 28/03/2024.
//

import CoreData

open class CoreDataService {
    
    // MARK: - Property
    public var mainContext: NSManagedObjectContext
    public var persistentContainer: NSPersistentContainer
    
    // MARK: - Initialization
    public init() {
        persistentContainer = NSPersistentContainer(name: "RecipeCoreDataModel")
        persistentContainer.loadPersistentStores { (_, error) in
            if let error = error {
                print("Something went wrong while loading persistent store \(error)")
            }
        }
        mainContext = self.persistentContainer.viewContext
    }
    
    // MARK: - Accessible
    func read<T: NSManagedObject>(entityType: T.Type, context: NSManagedObjectContext, predicate: NSPredicate?, sortDescriptors: [NSSortDescriptor]?) async -> [T]? {
        return await context.perform {
            let request: NSFetchRequest<T> = NSFetchRequest(entityName: String(describing: entityType))
            request.predicate = predicate
            request.sortDescriptors = sortDescriptors
            return try? context.fetch(request)
        }
    }
    func save(context: NSManagedObjectContext) async {
        await context.perform {
            try? context.save()
        }
    }
    func delete(objects: [NSManagedObject], context: NSManagedObjectContext) async {
        await context.perform {
            objects.forEach { context.delete($0) }
        }
    }
}
