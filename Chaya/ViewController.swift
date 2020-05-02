//
//  ViewController.swift
//  Chaya
//
//  Created by MI on 4/17/20.
//  Copyright © 2020 Mog. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UITableViewController {
    let realm = try! Realm()
    var catagories : Results<Catagory>? = nil
    var index : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
//    override func viewDidAppear(_ animated: Bool) {
//
//    }
    override func viewWillAppear(_ animated: Bool) {
        catagories = realm.objects(Catagory.self)
        self.tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if   !UserDefaults.standard.bool(forKey: "isShowOn") {
            let storyboard = UIStoryboard(name: "Onboarding", bundle: nil)
            let vc = (storyboard.instantiateViewController(withIdentifier: "OnboardingMain") as? OnboardingViewController)!
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
            
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (catagories?.count)!
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "catagoryCell", for: indexPath)
        cell.imageView?.frame = CGRect(x: 8, y: 8, width: 36, height: 36)
//        cell.imageView?.image = UIImage(named: catagories![indexPath.row].icon)
        
        cell.textLabel?.text = "\(catagories![indexPath.row].name) (\(catagories![indexPath.row].tasks.count))"
        return cell
        
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            do {
                try realm.write {
                    let tasks = catagories![indexPath.row].tasks
                    print(tasks)
                    realm.delete(tasks)
                    realm.delete(catagories![indexPath.row])
                    self.viewWillAppear(true)
                    print("Catagory Deleted.")
                }
            } catch {
                print("Error deleting Catagory.")
            }
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.index = indexPath.row
        performSegue(withIdentifier: "catagoryCellToTasks", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "catagoryCellToTasks"{
            let taskVC = segue.destination as! TasksTableViewController
            taskVC.catagory = catagories![index!]
        }
    }


}

