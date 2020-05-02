//
//  ActiveListViewController.swift
//  Chaya
//
//  Created by MI on 4/22/20.
//  Copyright © 2020 Mog. All rights reserved.
//

import UIKit
import RealmSwift
class ActiveListViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    let realm = try! Realm()
    var item : Results<Item>? = nil
    var catagories : Results<Catagory>? = nil
    var catagory : Catagory?
    var tasks : List<Task>?
    var buttonImage: UIImage = UIImage(systemName: "plus.circle")!
    
    var isGrantedNotificationAccess = false
    
    
    let date = Date()
    let format = DateFormatter()
    let calendar = Calendar.current
    
    //    var tasks = ["0", "1", "2"]
    @IBOutlet weak var tableView: UITableView!
    
    //    var catagoryDelegate : TasksViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonImage = UIImage(systemName: "plus.circle")!
        
        format.dateFormat = "yyyy-MM-dd"
        let formattedDate = format.string(from: date)
        print(formattedDate)
        
        print(calendar.component(.year, from: date))
        print(calendar.component(.month, from: date))
        print(calendar.component(.day, from: date))
        
        // Do any additional setup after loading the view, typically from a nib.
        UNUserNotificationCenter.current().requestAuthorization(
            options: [.alert,.sound,.badge],
            completionHandler: { (granted,error) in
                self.isGrantedNotificationAccess = granted
                if !granted{
                    //add alert to complain
                }
        })
        UNUserNotificationCenter.current().delegate = self
        
        item = realm.objects(Item.self)
        self.tableView.reloadData()
        
    }
    
    // MARK: - TableView Start
    override func viewWillAppear(_ animated: Bool) {
        item = realm.objects(Item.self)
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return item?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomeItemTableViewCell
        cell.title.text = item![indexPath.row].title
        cell.date.text = item![indexPath.row].date
        cell.icon.image = UIImage(named: item![indexPath.row].icon)
        cell.checkmark.image = item![indexPath.row].isCompleted ? UIImage(systemName: "checkmark.square") : UIImage(systemName: "stop")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72.0
    }
    
}


extension ActiveListViewController: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert,.sound])
    }
}
