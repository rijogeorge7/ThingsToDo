//
//  ViewController.swift
//  ThingsToDo
//
//  Created by Rijo George on 1/7/19.
//  Copyright © 2019 Rijo George. All rights reserved.
//

import UIKit

class ToDoListVC: UIViewController {

    @IBOutlet weak var todoTable: UITableView!
    let dataRepository = DataManager(todoRepository: ToDos())
    var todos : ToDos?
    let itemCellId = "ItemCell"
    let addEditSegueIdentifier = "AddEditSegue"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        todoTable.delegate = self
        todoTable.dataSource = self
        todos = dataRepository.getAllTodos()
        navigationItem.leftBarButtonItem = editButtonItem
//        let cell = Bundle.main.loadNibNamed("TableViewCell", owner: self, options: nil) as! TableViewCell
//        todoTable.register(TableViewCell.self, forCellReuseIdentifier: itemCellId)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == addEditSegueIdentifier {
            let itemAddEditVC = segue.destination as! ItemAddEditVC
            itemAddEditVC.tableActions = self
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
        destinationVC.todoItem = todos?.todosList[indexPath.section].list[indexPath.row]
        destinationVC.indexPath = indexPath
        destinationVC.tableActions = self
        navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    //swipe to delete
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        todos?.todosList[indexPath.section].list.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        dataRepository.deleteTodoItem(at: indexPath.row, for: indexPath.section)
    }
    
    //move raw functionality in editing mode
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        todos?.todosList = dataRepository.moveToDoItem(from: sourceIndexPath, to: destinationIndexPath)
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
    
//    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
//        return ["to dos", "Done"]
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let rows = todos?.todosList[section].list.count else {
            return 0
        }
        return rows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: itemCellId) as! ItemCell
        
        guard let name = todos?.todosList[indexPath.section].list[indexPath.row].name,
            let isDone = todos?.todosList[indexPath.section].list[indexPath.row].isDone else {
                return cell
        }
        cell.configureCell(name: name, isDone: isDone)
        return cell
    }
    
}

extension ToDoListVC : tableActions {
    func onEditItem(indexPath: IndexPath, item: ToDoItem) {
        todos?.todosList[indexPath.section].list[indexPath.row] = item
        todoTable.reloadData()
        dataRepository.insertTodoItem(item: item, at: indexPath.row, for: indexPath.section)
    }
    
    
    func onAddItem(section: Int, item: ToDoItem){
        todos?.todosList[section].addItem(item: item)
        todoTable.reloadData()
        dataRepository.appendTodoItem(item: item, for: section)
    }
    
}

protocol tableActions {
    func onAddItem(section: Int, item: ToDoItem)
    func onEditItem(indexPath: IndexPath, item: ToDoItem)
}
