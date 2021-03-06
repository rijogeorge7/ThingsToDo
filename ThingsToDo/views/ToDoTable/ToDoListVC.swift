//
//  ViewController.swift
//  ThingsToDo
//
//  Created by Rijo George on 1/7/19.
//  Copyright © 2019 Rijo George. All rights reserved.
//

import UIKit
import CoreData

class ToDoListVC: UIViewController {
    
    @IBOutlet weak var todoTable: UITableView!
    let dataRepository = DataManager(todoRepository: ToDos())
    var context : NSManagedObjectContext!
    var todos : ToDos?
    let itemCellId = "ItemCell"
    let addEditSegueIdentifier = "AddEditSegue"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        todoTable.delegate = self
        todoTable.dataSource = self
        let app = UIApplication.shared
        let appDelegate = app.delegate as! AppDelegate
        context = appDelegate.context
        todos = dataRepository.getAllTodos()
        navigationItem.leftBarButtonItem = editButtonItem
        //        let cell = Bundle.main.loadNibNamed("TableViewCell", owner: self, options: nil) as! TableViewCell
        //        todoTable.register(TableViewCell.self, forCellReuseIdentifier: itemCellId)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == addEditSegueIdentifier {
            let itemAddEditVC = segue.destination as! ItemAddEditVC
            itemAddEditVC.tableActions = self
            itemAddEditVC.context = context
        }
    }
    
}

extension ToDoListVC : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let destinationVC = mainStoryBoard.instantiateViewController(withIdentifier: "ItemAddEditVC") as? ItemAddEditVC else {
            return
        }
        // let destinationVC = self.storyboard?.instantiateViewController(withIdentifier: "ItemAddEditVC")
        destinationVC.context = context
        destinationVC.todoItem = todos?.todosList[indexPath.section].items[indexPath.row] as! ToDoItem
        destinationVC.indexPath = indexPath
        destinationVC.tableActions = self
        navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    //swipe to delete
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        dataRepository.deleteTodoItem(at: indexPath.row, for: indexPath.section)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        
    }
    
    //move raw functionality in editing mode
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        dataRepository.moveToDoItem(from: sourceIndexPath, to: destinationIndexPath)
        tableView.reloadData()
    }
    //editing mode
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: true)
        todoTable.setEditing(isEditing, animated: true)
    }
}

extension ToDoListVC : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let sectionCount = todos?.todosList.count else {
            return 0
        }
        return sectionCount
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = todos?.todosList[section].title
        label.backgroundColor = UIColor.red
        return label
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let rows = todos?.todosList[section].items.count else {
            return 0
        }
        return rows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: itemCellId) as! ItemCell
        
        guard let name = (todos?.todosList[indexPath.section].items[indexPath.row] as? ToDoItem)?.name,
            let isDone = (todos?.todosList[indexPath.section].items[indexPath.row] as? ToDoItem)?.isDone else {
                return cell
        }
        cell.configureCell(name: name, isDone: isDone)
        return cell
    }
    
}

extension ToDoListVC : tableActions {
    func onEditItem(indexPath: IndexPath, item: ToDoItem) {
        todos?.todosList[indexPath.section].replaceItems(at: indexPath.row, with: item)
        todoTable.reloadData()
        dataRepository.insertTodoItem(item: item, at: indexPath.row, for: indexPath.section)
    }
    
    
    func onAddItem(section: Int, item: ToDoItem){
        todos?.todosList[section].addToItems(item)
        todoTable.reloadData()
        dataRepository.appendTodoItem(item: item, for: section)
    }
    
}

protocol tableActions {
    func onAddItem(section: Int, item: ToDoItem)
    func onEditItem(indexPath: IndexPath, item: ToDoItem)
}
