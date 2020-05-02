//
//  TasksTableViewController.swift
//  Chaya
//
//  Created by MI on 4/17/20.
//  Copyright © 2020 Mog. All rights reserved.
//

import UIKit
import RealmSwift

//
//protocol TasksViewControllerDelegate {
//    func catagoryObject(item: Catagory)
//}
class TasksTableViewController: UITableViewController {
    let realm = try! Realm()
    var catagory : Catagory?
    var tasks : List<Task>?
    
    //    var catagoryDelegate : TasksViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = catagory?.name
    }
    
    // MARK: - TableView Start
    override func viewWillAppear(_ animated: Bool) {
        if let all = catagory?.tasks {
            tasks = all
        }
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath)
        cell.textLabel?.text = tasks![indexPath.row].name
//        cell.accessoryType = tasks![indexPath.row].isCompleted == true ? .checkmark : .none
        
//        let id = incrementID()
//        let item = Item()
//        if tasks![indexPath.row].isCompleted {
//
//            do{
//                try realm.write {
//                    
//                    item.id = id
//                    item.date = Date()
//                    item.name = tasks![indexPath.row].name
//                    item.isCompleted = false
//                    realm.add(item)
//                    print("Data preloaded.")
//                }
//            }catch{
//                print("Error preloading Data.")
//            }
//        } else  {
//            do {
//                try realm.write {
//                    realm.delete(item)
//                    print("Deleted task.")
//                }
//            } catch {
//                print("Error Deleting Task.")
//            }
//        }


        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            do {
                try realm.write {
                    realm.delete(tasks![indexPath.row])
                    self.viewWillAppear(true)
                    print("Deleted task.")
                }
            } catch {
                print("Error Deleting Task.")
            }
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected \(indexPath.row)")
//        
//        do {
//            try realm.write {
//                tasks![indexPath.row].isCompleted = tasks![indexPath.row].isCompleted == true ? false : true
//                self.viewWillAppear(true)
//                print("Task Updated.")
//            }
//        } catch {
//            print("Error updating Task.")
//        }
    }
    
    // MARK:- Leading Swipe for Editing
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let complete = UIContextualAction.init(style: .normal, title: "Edit") { (action, view, completion) in
            
            //...
            let alert = UIAlertController(title: "Edit Task", message: "", preferredStyle: .alert)
            
            let updateAction = UIAlertAction(title: "Update", style: .default, handler: { (UIAlertAction) in
                do {
                    // writing data in realm
                    try self.realm.write {
                        self.tasks![indexPath.row].name = (alert.textFields?.first?.text)!
                        self.viewWillAppear(true)
                    }
                }catch {
                    print("Task Cann't be added.")
                }
                
            })
            alert.addAction(updateAction)
            
            alert.addTextField { (textfield) in
                textfield.placeholder = "\(self.tasks![indexPath.row].name)"
                updateAction.isEnabled = false
                // Observe the UITextFieldTextDidChange notification to be notified in the below block when text is changed
                
                NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "UITextFieldTextDidChangeNotification"), object: textfield, queue: OperationQueue.main, using:
                    {_ in
                        // Being in this block means that something fired the UITextFieldTextDidChange notification.
                        
                        // Access the textField object from alertController.addTextField(configurationHandler:) above and get the character count of its non whitespace characters
                        let textCount = textfield.text?.trimmingCharacters(in: .whitespacesAndNewlines).count ?? 0
                        let textIsNotEmpty = textCount > 0
                        
                        // If the text contains non whitespace characters, enable the OK Button
                        updateAction.isEnabled = textIsNotEmpty
                }
                    
                )}
            alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        }
        
        let action = UISwipeActionsConfiguration.init(actions: [complete])
        action.performsFirstActionWithFullSwipe = true //... Full swipe support
        
        return action
        
    }
    // End Of Editing Task
    // End of Table
    
    // MARK: - New Task Methods
    @IBAction func onClickAddNewTask(_ sender: Any) {
        performSegue(withIdentifier: "allTaskToNewTask", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "allTaskToNewTask"{
            let vc = segue.destination as! NewTaskViewController
            vc.catagory = self.catagory
        }
    }
    
    func incrementID() -> Int {
        let id = (realm.objects(Task.self).max(ofProperty: "id") as Int? ?? 0) + 1
        return id
    }
    
    //  MARK:- NOtification Checklist
    // Notification permission in appDelegate
    // Set Notification Content
    // Set Notification Trigger
    // Set Notification Request
}
