//
//  TodoListController.swift
//  TodoList
//
//  Created by James Daniell on 22/09/2016.
//  Copyright © 2016 JamesDaniell. All rights reserved.
//

import UIKit
import CoreData

class TodoListController: UITableViewController , NSFetchedResultsControllerDelegate
{

    let managedObjectContext = DataController.sharedInstance.managedObjectContext
    
    lazy var fetchRequest: NSFetchRequest<NSFetchRequestResult> =
    {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: Item.identifier)
        let sortDescriptor = NSSortDescriptor(key: "text", ascending: true)
        request.sortDescriptors = [sortDescriptor]
        return request
    }()
    
    lazy var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult> =
    {
        let controller = NSFetchedResultsController<NSFetchRequestResult>(fetchRequest: self.fetchRequest, managedObjectContext: self.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        controller.delegate = self
        return controller
    }()
    override func viewDidLoad()
    {
        super.viewDidLoad()
        do
        {
            try self.fetchedResultsController.performFetch()
        }
        catch let error as NSError
        {
            print("Error fetching Item objects: \(error.localizedDescription), \(error.userInfo)")
        }
                // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return fetchedResultsController.sections?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        guard let section = fetchedResultsController.sections?[section] else { return 0 }
        return section.numberOfObjects
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        return configureCell(cell: cell, atIndexPath: indexPath as NSIndexPath)
    }
    
    private func configureCell(cell: UITableViewCell, atIndexPath indexPath: NSIndexPath) ->  UITableViewCell
    {
        let item = fetchedResultsController.object(at: indexPath as IndexPath) as! Item
        cell.textLabel?.text = item.text
        return cell
    }
    
    //MARK: NSFetchedReusltControllerDelegate
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>)
    {
        tableView.reloadData()
    }
 
    
}
