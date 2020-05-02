//
//  TaskListViewController.swift
//  Chaya
//
//  Created by MI on 4/30/20.
//  Copyright © 2020 Mog. All rights reserved.
//

import UIKit
import RealmSwift

class TaskListViewController: UIViewController {
    let realm = try! Realm()
    var catagory : Catagory?
    var tasks : List<Task>?
    
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: false)

        
        // Do any additional setup after loading the view.
    }
    
    // MARK: - TableView Start
    override func viewWillAppear(_ animated: Bool) {
        if let all = catagory?.tasks {
            tasks = all
        }
        self.tableView.reloadData()
    }
//    addNewTask
    @IBAction func onClickAddNewTask(_ sender: Any) {
        performSegue(withIdentifier: "addNewTask", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addNewTask"{
            let vc = segue.destination as! NewTaskListViewController
            vc.catagory = self.catagory
        }
    }
    
}

extension TaskListViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomeTableViewCell
        
        cell.titleLable.text = tasks![indexPath.row].name
        cell.icon.image = UIImage(named: tasks![indexPath.row].icon)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
}
