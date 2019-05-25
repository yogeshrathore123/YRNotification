//
//  ViewController.swift
//  YRNotification
//
//  Created by Yogesh Rathore on 25/05/19.
//  Copyright © 2019 Yogesh Rathore. All rights reserved.
//

import UIKit
import UserNotifications


@available(iOS 10.0, *)
class ViewController: UIViewController, UNUserNotificationCenterDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func type1NotificationClicked(_ sender: Any) {
        YRNotificationHandler().localNotificationDefault(delegate: self, title: "Local notification", body: "Hi Good Morning", timeInterval: 2, sound: UNNotificationSound.default)
    }
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert,.sound])
    }
}




extension UIApplication {
    static func topViewController() -> UIViewController? {
        guard var top = shared.keyWindow?.rootViewController else {
            return nil
        }
        while let next = top.presentedViewController {
            top = next
        }
        return top
    }
}


