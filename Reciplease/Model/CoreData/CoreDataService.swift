//
//  CoreDataService.swift
//  Reciplease
//
//  Created by François-Xavier on 28/03/2024.
//

import CoreData

protocol CoreDataServiceInterface: AnyObject {
    var mainContext: NSManagedObjectContext { get }
    var backgroundContext: NSManagedObjectContext { get }
    
    func save(context: NSManagedObjectContext) async
    func read<T: NSManagedObject>(entityType: T.Type, context: NSManagedObjectContext, predicate: NSPredicate?, sortDescriptors: [NSSortDescriptor]?) async -> [T]
    func delete(objects: [NSManagedObject], context: NSManagedObjectContext) async
}

final class CoreDataService: CoreDataServiceInterface {
    
    //MARK: - Singleton
    static let shared: CoreDataServiceInterface = CoreDataService()
    
    // MARK: - Property
    private let recipeModel: NSManagedObjectModel
    private lazy var container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "RecipeCoreDataModel", managedObjectModel: self.recipeModel)
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error {
                fatalError("Something went wrong \(error)")
            }
        })

        return container
    }()
    
    // MARK: - Initialization
    init() {
        guard let url = Bundle.main.url(forResource: "RecipeCoreDataModel", withExtension: "momd") else {
            fatalError("Something went wrong")
        }
        guard let model = NSManagedObjectModel(contentsOf: url) else {
            fatalError("Something went wrong")
        }
        self.recipeModel = model
    }

    // MARK: - Accessible
    var mainContext: NSManagedObjectContext {
        return self.container.viewContext
    }
    
    var backgroundContext: NSManagedObjectContext {
        return self.container.newBackgroundContext()
    }

    func save(context: NSManagedObjectContext) async {
        await context.perform {
            try? context.save()
        }
    }

    func read<T: NSManagedObject>(entityType: T.Type, context: NSManagedObjectContext, predicate: NSPredicate?, sortDescriptors: [NSSortDescriptor]?) async -> [T] {
        return await context.perform {
            let request: NSFetchRequest<T> = NSFetchRequest(entityName: String(describing: entityType))
            request.predicate = predicate
            request.sortDescriptors = sortDescriptors
            return (try? context.fetch(request)) ?? []
        }
    }

    func delete(objects: [NSManagedObject], context: NSManagedObjectContext) async {
        await context.perform {
            objects.forEach { context.delete($0) }
        }
    }
}
