//
//  ToDoGroup+CoreDataProperties.swift
//  ThingsToDo
//
//  Created by Rijo George on 1/26/19.
//  Copyright © 2019 Rijo George. All rights reserved.
//
//

import Foundation
import CoreData


extension ToDoGroup {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDoGroup> {
        return NSFetchRequest<ToDoGroup>(entityName: "ToDoGroup")
    }

    @NSManaged public var title: String
    @NSManaged public var items: NSOrderedSet

}

// MARK: Generated accessors for items
extension ToDoGroup {

    @objc(insertObject:inItemsAtIndex:)
    @NSManaged public func insertIntoItems(_ value: ToDoItem, at idx: Int)

    @objc(removeObjectFromItemsAtIndex:)
    @NSManaged public func removeFromItems(at idx: Int)

    @objc(insertItems:atIndexes:)
    @NSManaged public func insertIntoItems(_ values: [ToDoItem], at indexes: NSIndexSet)

    @objc(removeItemsAtIndexes:)
    @NSManaged public func removeFromItems(at indexes: NSIndexSet)

    @objc(replaceObjectInItemsAtIndex:withObject:)
    @NSManaged public func replaceItems(at idx: Int, with value: ToDoItem)

    @objc(replaceItemsAtIndexes:withItems:)
    @NSManaged public func replaceItems(at indexes: NSIndexSet, with values: [ToDoItem])

    @objc(addItemsObject:)
    @NSManaged public func addToItems(_ value: ToDoItem)

    @objc(removeItemsObject:)
    @NSManaged public func removeFromItems(_ value: ToDoItem)

    @objc(addItems:)
    @NSManaged public func addToItems(_ values: NSOrderedSet)

    @objc(removeItems:)
    @NSManaged public func removeFromItems(_ values: NSOrderedSet)

}
