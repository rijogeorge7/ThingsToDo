//
//  ToDoSet.swift
//  ThingsToDo
//
//  Created by Rijo George on 1/7/19.
//  Copyright © 2019 Rijo George. All rights reserved.
//

import Foundation
struct ToDoSet : Codable {
    var title : String
    var list : [ToDoItem]
    
    init (title:String) {
        self.title = title
        list = [ToDoItem]()
    }
    
    mutating func addItem(item : ToDoItem) {
        list.append(item)
    }
    
    
}
