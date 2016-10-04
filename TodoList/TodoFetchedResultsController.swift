//
//  TodoFetchedResultsController.swift
//  TodoList
//
//  Created by James Daniell on 23/09/2016.
//  Copyright © 2016 JamesDaniell. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class TodoFetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>, NSFetchedResultsControllerDelegate
{
    private let tableView: UITableView
    
    init(managedObjectContext: NSManagedObjectContext, withTableView tableView: UITableView)
    {
        self.tableView = tableView
        super.init(fetchRequest: Item.itemFetchRequest, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        self.delegate = self
        
        tryFetch()
    }
    
    func tryFetch()
    {
        do
        {
            try performFetch()
        }
        catch let error as NSError
        {
            print("Unresolved error: \(error), \(error.userInfo)")
        }
    }
    
    //MARK: NSFetchedReusltControllerDelegate
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>)
    {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>)
    {
        tableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?)
    {
        switch type
        {
            case .insert:
                guard let indexPath = newIndexPath else { return }
                tableView.insertRows(at: [indexPath], with: .automatic)
            case .delete:
                guard let indexPath = indexPath else { return }
                tableView.deleteRows(at: [indexPath], with: .automatic)
            case .update, .move:
                guard let indexPath = indexPath else {return }
                tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
    
   
    
}
