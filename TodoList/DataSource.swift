//
//  DataSource.swift
//  TodoList
//
//  Created by James Daniell on 04/10/2016.
//  Copyright © 2016 JamesDaniell. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class DataSource: NSObject , UITableViewDataSource
{
    private let tableView: UITableView
    
    let managedObjectContext = DataController.sharedInstance.managedObjectContext
    
    
    lazy var fetchedResultsController: TodoFetchedResultsController =
    {
            let controller = TodoFetchedResultsController(managedObjectContext: self.managedObjectContext, withTableView: self.tableView)
            return controller
    }()
    
    init(tableView: UITableView)
    {
        self.tableView = tableView
    }
    
    func objectAtIndexPath(indexPath: NSIndexPath) -> NSManagedObject
    {
        return fetchedResultsController.object(at: indexPath as IndexPath) as! NSManagedObject
    }
    
    // MARK: - UI Table view data source protocol
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return fetchedResultsController.sections?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        guard let section = fetchedResultsController.sections?[section] else { return 0 }
        return section.numberOfObjects
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        return configureCell(cell: cell, atIndexPath: indexPath as NSIndexPath)
    }
    
    func configureCell(cell: UITableViewCell, atIndexPath indexPath: NSIndexPath) ->  UITableViewCell
    {
        let item = fetchedResultsController.object(at: indexPath as IndexPath) as! Item
        cell.textLabel?.text = item.text
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        let item = fetchedResultsController.object(at: indexPath) as! NSManagedObject
        managedObjectContext.delete(item)
        DataController.sharedInstance.saveContext()
    }
}
