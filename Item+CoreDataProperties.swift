//
//  Item+CoreDataProperties.swift
//  TodoList
//
//  Created by James Daniell on 22/09/2016.
//  Copyright © 2016 JamesDaniell. All rights reserved.
//

import Foundation
import CoreData


extension Item {

    

    @NSManaged public var text: String?
    @NSManaged public var completed: Bool

}
