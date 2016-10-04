//
//  CoreDataStack.swift
//  TodoList
//
//  Created by James Daniell on 21/09/2016.
//  Copyright © 2016 JamesDaniell. All rights reserved.
//

import Foundation
import CoreData

class DataController: NSObject
{
    static let sharedInstance = DataController()
    
    private override init() {}
    
    private lazy var applicationDocumentsDirectory: NSURL = {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[urls.count - 1] as NSURL
    }()
    
    
    private lazy var managedObjectModel: NSManagedObjectModel = {
        let modelURL = Bundle.main.url(forResource: "TodoList", withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()
    
    private lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.appendingPathComponent("TodoList.sqlite")
        
        do
        {
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: nil)
        }
        catch
        {
            let UserInfo: [String: AnyObject] = [
                NSLocalizedDescriptionKey: "Failed to initialize the application's saved data" as AnyObject ,
                NSLocalizedFailureReasonErrorKey: " There was an error creating or loading application's saved data" as AnyObject ,
                NSUnderlyingErrorKey: error as NSError
            ]
            
            let wrappedError = NSError(domain: "com.JamieDaniell.CoreDataError", code: 9999 , userInfo: UserInfo)
            print("Unresolved Error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        return coordinator
    }()
    
    public lazy var managedObjectContext: NSManagedObjectContext =
    {
        let coordinator = self.persistentStoreCoordinator
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        
        managedObjectContext.persistentStoreCoordinator = coordinator
        
        return managedObjectContext
    }()
    
    public func saveContext()
    {
        if managedObjectContext.hasChanges
        {
            do
            {
                try managedObjectContext.save()
            }
            catch let error as NSError
            {
                print("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
}









































