//
//  ViewController.swift
//  ToDoList
//
//  Created by apple on 20/09/21.
//  Copyright © 2021 apple. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var listModel: [ListModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "To Do List"
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    @IBAction func editTapped(_ sender: UIBarButtonItem) {
    }
    
    
    @IBAction func addTapped(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "Add Task", message: "Add New Task", preferredStyle: .alert)
        
        alert.addTextField {(textField1) in
            textField1.placeholder = "Task Name"
            
        }
        alert.addTextField {(textField2) in
            textField2.placeholder = "Location"
            
        }
        
        let addTaskAction = UIAlertAction(title: "Add Task", style: .default) { (addAction) in
            
            if let taskName = alert.textFields?.first?.text, let address = alert.textFields?.last?.text{
                
                if (taskName != "") && (address != ""){
                    
                    let toDoList = ListModel(name: taskName, location: address, isFavorite: false )
                    
                    self.listModel.append(toDoList)
                    self.tableView.reloadData()
                    
                }
                else if (taskName == "") && (address == ""){
                    let alert2 = UIAlertController(title: "Error", message: "Fill both the fields", preferredStyle: .alert)
                    let okAction2 = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alert2.addAction(okAction2)
                    self.present(alert2, animated: true, completion: nil)
                    
                }
                else if taskName == ""{
                    let alert3 = UIAlertController(title: "Error", message: "Task Name field is empty", preferredStyle: .alert)
                    let okAction2 = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alert3.addAction(okAction2)
                    self.present(alert3, animated: true, completion: nil)
                }else{
                    let alert4 = UIAlertController(title: "Error", message: "Location field is empty", preferredStyle: .alert)
                    let okAction2 = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alert4.addAction(okAction2)
                    self.present(alert4, animated: true, completion: nil)
                }
            }
            
            
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(addTaskAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
}


extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return listModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = self.listModel[indexPath.row].name
        cell.detailTextLabel?.text = self.listModel[indexPath.row].location
        return cell
    }
    
    
    
    //    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    //        return true
    //    }
    
    //    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    //        if editingStyle == .delete {
    //            tableView.beginUpdates()
    //            listModel.remove(at: indexPath.row)
    //            tableView.deleteRows(at: [indexPath], with: .fade)
    //            tableView.endUpdates()
    //
    //        }
    //    }
    
    
    
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        
        let delete = UIContextualAction(style: .normal, title: "Delete") { (action, view, completionHandler) in
            
            tableView.beginUpdates()
            self.listModel.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
            print("Delete: \(indexPath.row + 1)")
            completionHandler(true)
            
        }
        delete.image = UIImage(systemName: "trash")
        delete.backgroundColor = .red
        
        
        
        
        
        var todo = listModel[indexPath.row]
        
        let favorite = UIContextualAction(style: .normal, title: "Favourite") { (action, view, completionHandler) in
            
            todo.isFavorite.toggle()
            
            print(todo.isFavorite)
            completionHandler(true)
        }
        favorite.image = UIImage(systemName: "suit.heart.fill")
        
        
        let swipe = UISwipeActionsConfiguration(actions: [delete, favorite])
        return swipe
        
    }
    
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        
        
        let profile = UIContextualAction(style: .normal, title: "Share") { (action, view, completionHandler) in
            print("Share: \(indexPath.row + 1)")
            completionHandler(true)
        }
        profile.image = UIImage(systemName: "person.fill")
        
        
        let share = UIContextualAction(style: .normal, title: "Share") { (action, view, completionHandler) in
            print("Share: \(indexPath.row + 1)")
            completionHandler(true)
        }
        share.image = UIImage(systemName: "square.and.arrow.up")
        
        let swipe = UISwipeActionsConfiguration(actions: [profile, share])
        return swipe
    }
    
    
}

