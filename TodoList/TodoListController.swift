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

    lazy var dataSource: DataSource =
    {
        return DataSource(tableView: self.tableView)
    }()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        tableView.dataSource = dataSource
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "showItem"
        {
            guard let destinationController = segue.destination as? DetailViewController, let indexPath = tableView.indexPathForSelectedRow else {return}
            let item = dataSource.objectAtIndexPath(indexPath: indexPath as NSIndexPath) as! Item
            destinationController.item = item
        }
    }
   
     //MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle
    {
        return .delete
    }
    
    
   
 
    
}
