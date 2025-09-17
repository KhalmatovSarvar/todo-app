//
//  PersistentContainer.swift
//  TODO app
//
//  Created by Sarvar on 16/09/25.
//


import CoreData
import Foundation

final class PersistentContainer: NSPersistentContainer {
    private static let modelName = "TODO_app"
    
    static let shared: PersistentContainer = {
        guard let modelURL = Bundle.main.url(forResource: modelName, withExtension: "momd") else {
            fatalError("Failed to find model in bundle.")
        }
        guard let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Failed to initialize managed object model.")
        }
        let container = PersistentContainer(name: PersistentContainer.modelName, managedObjectModel: managedObjectModel)
        container.setup()
        return container
    }()
    
    func setup() {
        loadPersistentStores { _, error in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        
        viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
    }
    
    /// A convenience method for creating background contexts that specify the app as their transaction author.
    /// It's best practice to perform heavy lifting on a background context.
    ///
    /// - Returns: The background context configured with a name and transaction author.
    override func newBackgroundContext() -> NSManagedObjectContext {
        let context = super.newBackgroundContext()
        context.name = "background_context"
        context.transactionAuthor = "main_app_background_context"
        context.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        context.automaticallyMergesChangesFromParent = true
        return context
    }
}
