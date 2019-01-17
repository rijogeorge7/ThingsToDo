//
//  ToDos.swift
//  ThingsToDo
//
//  Created by Rijo George on 1/8/19.
//  Copyright © 2019 Rijo George. All rights reserved.
//

import Foundation

struct ToDos : ToDoRepository, Codable{

    static let jsonFileName = "todos"
    var todosList : [ToDoSet]
    init() {
        todosList = [ToDoSet]()
    }
    
    mutating func getAllTodos() -> ToDos {
        let documentDirectory = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor:nil, create:false)
        let jsonUrl = documentDirectory.appendingPathComponent(ToDos.jsonFileName)
            .appendingPathExtension("json")
        let jsonDecoder = JSONDecoder()
        let jsonSavedData = try? Data(contentsOf: jsonUrl)
        if let jsonData=jsonSavedData {
            let todos = try! jsonDecoder.decode(ToDos.self, from: jsonData)
            return todos
        }
        
        let notDoneTodos = createDummyNotToDoSet()
        let doneTodos = createDummyToDoSet()
        var toDos = ToDos()
        todosList.append(notDoneTodos)
        todosList.append(doneTodos)
        toDos.todosList = self.todosList
        return toDos
    }
    
    mutating func appendTodoItem(item: ToDoItem, for section: Int) {
        todosList[section].addItem(item: item)
        persistDataToDiskAsJson()
    }
    
    mutating func insertTodoItem(item: ToDoItem, at position: Int, for section: Int) {
        todosList[section].list[position] = item
        persistDataToDiskAsJson()
    }
    
    mutating func deleteTodoItem(at position: Int, for section: Int) {
        todosList[section].list.remove(at: position)
        persistDataToDiskAsJson()
    }
    
    mutating func moveToDoItem(from: IndexPath, to: IndexPath) -> [ToDoSet] {
        let fromItem = todosList[from.section].list[from.row]
        //if let toItem = todosList[to.section].list[to.row] {
        if todosList[to.section].list.count > to.row {
            let toItem = todosList[to.section].list[to.row]
            todosList[from.section].list[from.row] = toItem
            todosList[to.section].list[to.row] = fromItem
        } else {
            todosList[to.section].list.append(fromItem)
            todosList[from.section].list.remove(at: from.row)
        }
        
        persistDataToDiskAsJson()
        return todosList
    }
    
    func persistDataToDiskAsJson() {
        do {
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor:nil, create:false)
            let jsonUrl = documentDirectory.appendingPathComponent(ToDos.jsonFileName)
                .appendingPathExtension("json")
            let jsonEncoder = JSONEncoder()
            let jsonData = try jsonEncoder.encode(self)
            try jsonData.write(to: jsonUrl)
        } catch {
            print(error)
        }
    }
    
    
    //MARK: dummy data creation methods
    
    private func createDummyNotToDoSet() -> ToDoSet {
        return ToDoSet(title: "To Do")
    }
    
    private func createDummyToDoSet() -> ToDoSet {
        return ToDoSet(title: "Done")
    }
}

