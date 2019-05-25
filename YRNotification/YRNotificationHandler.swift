//
//  YRNotificationHandler.swift
//  YRNotification
//
//  Created by Yogesh Rathore on 25/05/19.
//  Copyright © 2019 Yogesh Rathore. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications


public class YRNotificationHandler: NSObject {
    public override init() {
        super.init()
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.badge,.sound], completionHandler: {(granted,error) in
                if !granted {
                    self.presentNotificationSettings()
                }
            })
        } else {
            // Fallback on earlier versions
        }
    }
    
    @available(iOS 10.0, *)
    
    /// function to trigger local notification
    ///
    /// - Parameters:
    ///   - delegate: UIViewController
    ///   - title: title of the notification
    ///   - body: body of the notification
    ///   - timeInterval: timeInterval before the notification appears
    ///   - sound: sound of the notification
    public func localNotificationDefault(delegate: UIViewController, title: String, body: String, timeInterval: TimeInterval, sound: UNNotificationSound = UNNotificationSound.default) {
        UNUserNotificationCenter.current().delegate = delegate as? UNUserNotificationCenterDelegate
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = sound
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: false)
        let request = UNNotificationRequest(identifier: "test", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        
    }
    
    // Mark:: Open Notification Setting
    public func presentNotificationSettings() {
        let alertController = UIAlertController(title: "Permissions needed",
                                                message: "Notifications is denied for this app. You can turn on Notifications for this app in Settings.",
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Later", style: .default))
        alertController.addAction(UIAlertAction(title: "Settings", style: .cancel) { _ in
            if let url = URL(string: UIApplication.openSettingsURLString) {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url, options: [:], completionHandler: { _ in
                        // Handle
                    })
                } else {
                    // Fallback on earlier versions
                }
            }
        })
       
    UIApplication.topViewController()!.present(alertController, animated: true)
    }
}
