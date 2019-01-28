//
//  ToDoItem+CoreDataProperties.swift
//  ThingsToDo
//
//  Created by Rijo George on 1/26/19.
//  Copyright © 2019 Rijo George. All rights reserved.
//
//

import Foundation
import CoreData


extension ToDoItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDoItem> {
        return NSFetchRequest<ToDoItem>(entityName: "ToDoItem")
    }

    @NSManaged public var isDone: Bool
    @NSManaged public var name: String
    @NSManaged public var group: ToDoGroup

}
