//
//  ItemAddEditVC.swift
//  ThingsToDo
//
//  Created by Rijo George on 1/8/19.
//  Copyright © 2019 Rijo George. All rights reserved.
//

import UIKit

class ItemAddEditVC: UIViewController {

    
    @IBOutlet weak var itemText: UITextField!
    var tableActions : tableActions? = nil
    var todoItem: ToDoItem? = nil
    var indexPath: IndexPath? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let text = todoItem?.name {
            itemText.text = text
        }
    }
    
    //MARK: IB Actions
    
    @IBAction func doneTapped(_ sender: Any) {
        if(todoItem == nil) {
            addItem(itemText: itemText.text)
            navigationController?.popViewController(animated: true)
        } else {
            editItem(newText: itemText.text)
            navigationController?.popViewController(animated: true)
        }
        
    }
    
    @IBAction func cancelled(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    func addItem(itemText: String?) {
        guard let text = itemText else {
            return
        }
        let toDoItem = ToDoItem(name: text, isDone: false)
        tableActions?.onAddItem(section: 0, item: toDoItem)
    }
    
    func editItem(newText: String?) {
        if(newText == nil || indexPath == nil || todoItem == nil) {
            return
        }
        todoItem?.name = newText!
        tableActions?.onEditItem(indexPath: indexPath!, item: todoItem!)
    }
    
}
