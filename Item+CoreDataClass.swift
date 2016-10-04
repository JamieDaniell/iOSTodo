//
//  Item+CoreDataClass.swift
//  TodoList
//
//  Created by James Daniell on 22/09/2016.
//  Copyright © 2016 JamesDaniell. All rights reserved.
//

import Foundation
import CoreData


class Item: NSManagedObject
{

    static let identifier = "Item"
    
    static let itemFetchRequest: NSFetchRequest<NSFetchRequestResult> =
    {
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: Item.identifier)
            let sortDescriptor = NSSortDescriptor(key: "text", ascending: true)
            request.sortDescriptors = [sortDescriptor]
            return request
    }()
}
