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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomeTableViewCell
        let id = "\(format.string(from: date))-\(item![indexPath.row].id)"
        
        cell.titleLable.text = item![indexPath.row].title
        cell.dateLable.text = "none"
//        cell.addButton.setBackgroundImage(tasks![indexPath.row].isCompleted == true ? UIImage(systemName: "plus.circle") : UIImage(systemName: "minus.circle"), for: .normal)
        buttonImage = UIImage(systemName: "plus.circle")!
        //        setButtonImage(id: id)
        cell.addButton.setBackgroundImage(buttonImage, for: .normal)
        
        
        
        cell.cellDelegate = self
        cell.index = id
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72.0
    }
    
    func setButtonImage(id: String) {
        UNUserNotificationCenter.current().getPendingNotificationRequests(completionHandler: {requests -> () in
            if requests.count > 0 {
                for request in requests{
                    print("koi")
                    if request.identifier == id {
                        print("hi")
                        //                        self.buttonImage = UIImage(systemName: "minus.circle")!
                        //                        break
                        
                        //                        let task = Task()
                        
                        
                    }
                }
            }
            
        })
    }
}


extension ActiveListViewController: AddButtonDelegate {
    
    func onclick(id: String) {
        print(id)
        if isGrantedNotificationAccess{
            //set content
            let content = UNMutableNotificationContent()
            content.title = "My Notification Management Demo"
            content.subtitle = "Timed Notification"
            content.body = "Notification pressed"
            content.categoryIdentifier = "message"
            
            //set trigger
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10.0, repeats: false)
            //            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60.0, repeats: true)
            
            //Create the request
            let request = UNNotificationRequest(
                identifier: id,
                content: content,
                trigger: trigger
            )
            //Schedule the request
            UNUserNotificationCenter.current().add(
                request, withCompletionHandler: nil)
            
//            let task = self.realm.objects(Task
//                .self).filter("nid == \(id)").first
//            try! self.realm.write {
//                task!.isCompleted = true
//            }
            
            tableView.reloadData()
        }
        
    }
}

extension ActiveListViewController: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert,.sound])
    }
}
