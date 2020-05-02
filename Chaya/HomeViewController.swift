//
//  HomeViewController.swift
//  Chaya
//
//  Created by MI on 4/20/20.
//  Copyright © 2020 Mog. All rights reserved.
//

import UIKit
import RealmSwift

class HomeViewController: UIViewController {
    let realm = try! Realm()
    var catagories : Results<Catagory>? = nil
    var index: Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        print(realm.configuration.fileURL!.deletingLastPathComponent().path)
        


        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        catagories = realm.objects(Catagory.self)
    }
    

    @IBAction func onBittonClick(_ sender: UIButton) {
        index = sender.tag
        performSegue(withIdentifier: "TaskList", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "TaskList"{
            let taskVC = segue.destination as! TaskListViewController
            taskVC.catagory = catagories![index!]
        }
    }
    
}
