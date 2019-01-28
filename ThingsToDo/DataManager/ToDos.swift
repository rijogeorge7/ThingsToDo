//
//  ToDos.swift
//  ThingsToDo
//
//  Created by Rijo George on 1/8/19.
//  Copyright © 2019 Rijo George. All rights reserved.
//

import Foundation
import CoreData
import UIKit

struct ToDos : ToDoRepository{

    var todosList : [ToDoGroup]
    lazy var context : NSManagedObjectContext = {
        let application = UIApplication.shared
        let delegate = application.delegate as! AppDelegate
        return delegate.context
    }()
    init() {
        todosList = [ToDoGroup]()
    }
    
    mutating func getAllTodos() -> ToDos {
        
        let fetchGroupRequest : NSFetchRequest<ToDoGroup> = ToDoGroup.fetchRequest()
        var groups : [ToDoGroup]!
        do{
            groups = try context.fetch(fetchGroupRequest)
        } catch {
            
        }
        if groups == nil || groups.count<2 {
            todosList.append(createDummyNotToDoSet())
            todosList.append(createDummyToDoSet())
        } else {
            todosList = groups
        }
        
        return self
        }
    
    
    mutating func appendTodoItem(item: ToDoItem, for section: Int) {
        todosList[section].addToItems(item)
        persistDataToStore()
    }
    
    mutating func insertTodoItem(item: ToDoItem, at position: Int, for section: Int) {
        todosList[section].insertIntoItems(item, at: position)
        persistDataToStore()
    }
    
    mutating func deleteTodoItem(at position: Int, for section: Int) {
//        todosList[section].list.remove(at: position)
//        persistDataToStore()
    }
    
    mutating func moveToDoItem(from: IndexPath, to: IndexPath) -> [ToDoSet] {
//        let fromItem = todosList[from.section].list[from.row]
//        //if let toItem = todosList[to.section].list[to.row] {
//        if todosList[to.section].list.count > to.row {
//            let toItem = todosList[to.section].list[to.row]
//            todosList[from.section].list[from.row] = toItem
//            todosList[to.section].list[to.row] = fromItem
//        } else {
//            todosList[to.section].list.append(fromItem)
//            todosList[from.section].list.remove(at: from.row)
//        }
//
//        persistDataToStore()
//        return todosList
        return [ToDoSet]()
    }
    
    mutating func persistDataToStore() {
        if context.hasChanges {
            
        do{
            try context.save()
        } catch {
            
        }
        }
    }

    func convertGroupsIntoToDOList(groups: [ToDoGroup]) -> [ToDoSet] {
        var toList = [ToDoSet]()
        for group in groups {
            toList.append(ToDoSet(title: group.title))
        }
           return toList
    }
    
    
    //MARK: dummy data creation methods
    
    private mutating func createDummyNotToDoSet() -> ToDoGroup {
        let toDoGroup = ToDoGroup(context: context)
        toDoGroup.title = "To Do"
        persistDataToStore()
        return toDoGroup
    }
    
    private mutating func createDummyToDoSet() -> ToDoGroup {
        let toDoGroup = ToDoGroup(context: context)
        toDoGroup.title = "Done"
        persistDataToStore()
        return toDoGroup
    }
}

