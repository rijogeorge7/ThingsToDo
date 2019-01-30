//
//  DataRepository.swift
//  ThingsToDo
//
//  Created by Rijo George on 1/7/19.
//  Copyright © 2019 Rijo George. All rights reserved.
//

import Foundation
protocol ToDoRepository {
    mutating func getAllTodos() -> ToDos
    mutating func appendTodoItem(item : ToDoItem, for section: Int)
    mutating func insertTodoItem(item: ToDoItem, at position: Int, for section: Int)
    mutating func deleteTodoItem(at position: Int, for section: Int)
    mutating func moveToDoItem(from: IndexPath, to: IndexPath) 
}
