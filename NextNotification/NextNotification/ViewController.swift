//
//  ViewController.swift
//  NextNotification
//
//  Created by Valmir Junior on 10/11/18.
//  Copyright © 2018 Valmir Junior. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var subtitleTextField: UITextField!
    @IBOutlet weak var bodyTextField: UITextField!
    @IBOutlet weak var notificationDatePicker: UIDatePicker!
    
    
    // MARK: - Super Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.notificationDatePicker.minimumDate = Date()
    }
    
    

    @IBAction func scheduleNotification(_ sender: Any) {
        
        let id = String(Date().timeIntervalSince1970)
        let content = UNMutableNotificationContent()
        content.title = self.titleTextField.text ?? ""
        content.subtitle = self.subtitleTextField.text ?? ""
        content.body = self.bodyTextField.text ?? ""
        
        // sound file must exist in app bundle resources
        // content.sound = UNNotificationSound(named: "notification.caf")
        
        content.categoryIdentifier = "lembrete"
        
        // 3 types of triggers
        // geofence
        // interval of time
        // date
        
        // interval of time
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        
        let dateComponets = Calendar.current.dateComponents([.year, .month, .day, .hour], from: self.notificationDatePicker.date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponets, repeats: false)
        
        
        let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { (error) in
            print(error?.localizedDescription ?? "")
        }

    }
    
}

