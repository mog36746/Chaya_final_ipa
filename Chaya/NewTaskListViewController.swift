//
//  NewTaskListViewController.swift
//  Chaya
//
//  Created by MI on 4/30/20.
//  Copyright © 2020 Mog. All rights reserved.
//

import UIKit
import RealmSwift
class NewTaskListViewController: UIViewController {
    let realm = try! Realm()
    var catagory : Catagory?
    
    @IBOutlet weak var editText: UITextField!


    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onClickSave(_ sender: Any) {
//        print("\(dueDate) \n \(reminder) \n \(editText.text!)")
        let id = incrementID()
        
        do {
            try realm.write {
                if let singleCat = catagory {
                    let task = Task()
                    task.id = id
                    task.name = editText.text!
                    singleCat.tasks.append(task)
                }
            }
        } catch {
            print("data not added.")
        }
        navigationController?.popViewController(animated: true)
    }
    
    func incrementID() -> Int {
        let id = (realm.objects(Task.self).max(ofProperty: "id") as Int? ?? 0) + 1
        return id
    }

}
