//
//  AddNewItemViewController.swift
//  Chaya
//
//  Created by MI on 4/30/20.
//  Copyright © 2020 Mog. All rights reserved.
//


import UIKit
import UserNotifications
import RealmSwift

class AddNewItemViewController: UIViewController, UITextFieldDelegate {
    let realm = try! Realm()
    @IBOutlet weak var editText: UITextField!
    @IBOutlet weak var reminderSwitch: UISwitch!
    @IBOutlet weak var datePickerLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var datePickerView: UIView!
    @IBOutlet weak var doneButtonOutlet: UIBarButtonItem!
    
    var dueDate = Date()
    var reminder = false
    
    let date = Date()
    let format = DateFormatter()
    let calendar = Calendar.current
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        format.dateFormat = "yyyy-MM-dd"
        let formattedDate = format.string(from: date)
        print(formattedDate)
        
        self.hideKeyboardOnTap()
        editText.becomeFirstResponder()
        // Do any additional setup after loading the view.
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yy-mm-dd hh:mm"
        datePickerView.isHidden = true
        datePickerLabel.text = dateFormatter.string(from: dueDate)
    }
    
    
    // MARK:- Text Field Delegate Start
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        let oldText = editText.text!
        let stringRange = Range(range, in:oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)

            if newText.isEmpty {
            doneButtonOutlet.isEnabled = false
            } else {
            doneButtonOutlet.isEnabled = true
            }
            return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        doneButtonOutlet.isEnabled = false
        return true
    }
    //End of Textfield delegate
    
    //MARK:- Writing into database
    @IBAction func onClickDone(_ sender: Any) {
        print("\(dueDate) \n \(reminder) \n \(editText.text!)")
        let id = incrementID()
        scheduleNotification(id: id)
        let nid = "\(format.string(from: date))-\(id)"
        
        do {
            try realm.write {
                let item = Item()
                item.id = id
                item.title = editText.text!
                realm.add(item)
            }
        } catch {
            print("data not added.")
        }
        navigationController?.popViewController(animated: true)
    }
    //end of writing into database
    
    //MARK:- Internal workings
    // such as enabling and disabling views based on certain action
    @IBAction func onChangeDatePicker(_ sender: UIDatePicker) {
        print(sender.date)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yy-mm-dd hh:mm"
        datePickerLabel.text = dateFormatter.string(from: sender.date)
        dueDate = sender.date
    }
    
    @IBAction func reminderSwich(_ sender: UISwitch) {
        if sender.isOn == true {
            datePickerView.isHidden = false
            reminder = true
        }else{
            datePickerView.isHidden = true
            reminder = false
        }
    }
    
    func scheduleNotification(id: Int){
        if reminder && dueDate > Date(){
            print("Scheduling Notification")
            let content = UNMutableNotificationContent()
            content.title = "You've a task in pending."
            content.body = editText.text!
            content.sound = UNNotificationSound.default
            
            let calender = Calendar(identifier: .gregorian)
            let components = calender.dateComponents([.year,.month,.day,.hour,.minute], from: dueDate)
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
            
            let request = UNNotificationRequest(identifier: "task-\(id)", content: content, trigger: trigger)
            let center = UNUserNotificationCenter.current()
            center.add(request)
            print("added")
        }
    }
    
    func incrementID() -> Int {
        let id = (realm.objects(Task.self).max(ofProperty: "id") as Int? ?? 0) + 1
        return id
    }


}
