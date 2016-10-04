//
//  DetailViewController.swift
//  TodoList
//
//  Created by James Daniell on 04/10/2016.
//  Copyright © 2016 JamesDaniell. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController
{

    var item: Item?
    @IBOutlet weak var textField: UITextField!
    
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        guard let item = item else { fatalError("Cannot show detail without an item")}
        textField.text = item.text
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func save(_ sender: AnyObject)
    {
        if let item = item
        {
            item.text = textField.text
            DataController.sharedInstance.saveContext()
            self.navigationController?.popViewController(animated: true)
        }
    }
    

   

}
