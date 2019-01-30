//
//  DataManager.swift
//  ThingsToDo
//
//  Created by Rijo George on 1/7/19.
//  Copyright © 2019 Rijo George. All rights reserved.
//

import Foundation
class DataManager : DataRepository{
    
    var todoRepository : ToDoRepository
    init(todoRepository : ToDoRepository) {
        self.todoRepository = todoRepository
    }
    
    func getAllTodos() -> ToDos {
        return todoRepository.getAllTodos()
    }
    
    func appendTodoItem(item: ToDoItem, for section: Int) {
        todoRepository.appendTodoItem(item: item, for: section)
    }
    
    func insertTodoItem(item: ToDoItem, at position: Int, for section: Int) {
        todoRepository.insertTodoItem(item: item, at: position, for: section)
    }
    
    func deleteTodoItem(at position: Int, for section: Int) {
        todoRepository.deleteTodoItem(at: position, for: section)
    }
    
    func moveToDoItem(from: IndexPath, to: IndexPath) {
        todoRepository.moveToDoItem(from: from, to: to)
    }
}
