//
//  AppDelegate.swift
//  FFNotificationsUI
//
//  Created by zhou on 2019/7/30.
//  Copyright © 2019 MissZhou. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        /// Request local notification authorizations.
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (accepted, error) in
            if !accepted {
                print("Notification access denied.")
            }
        }
        
        /// Render actions for notification
        let action = UNNotificationAction(identifier: "remindLater", title: "Remind me later", options: [])
        let category = UNNotificationCategory(identifier: "normal", actions: [action], intentIdentifiers: [], options: [])
        UNUserNotificationCenter.current().setNotificationCategories([category])
        
        return true
    }
    
    /// create a local notification at specific date.
    ///
    /// - Paraeter date: Time to trigger notification
    func scheduleNotification(at date: Date) {
        UNUserNotificationCenter.current().delegate = self
        
        /// Create date component from date.
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents(in: .current, from: date)
        let newComponents = DateComponents.init(calendar: calendar, timeZone: .current, era: components.era, year: components.year, month: components.month, day: components.day, hour: components.hour, minute: components.minute, second: components.second)
        
        /// Create trigger and content
        let tigger = UNCalendarNotificationTrigger(dateMatching: newComponents, repeats: false)
        let content = UNMutableNotificationContent()
        content.title = "Coding Reminder"
        content.body = "Ready to code? Let us do some Swift!"
        content.sound = UNNotificationSound.default
        content.categoryIdentifier = "normal"
        
        /// add a image as attachment
        if let path = Bundle.main.path(forResource: "Swift", ofType: "png") {
            let url = URL(fileURLWithPath: path)
            
            do {
                let attachment = try UNNotificationAttachment(identifier: "Swift", url: url , options: nil)
                content.attachments = [attachment]
            } catch {
                print("The attachment was not loaded.")
            }
        }
        
        /// Make a notification request
        let request = UNNotificationRequest(identifier: "textNotification", content: content, trigger: tigger)
        
        /// Remove pending notifications to avoid duplicates
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        
        /// Provide request to notification center
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print("Error:" + error.localizedDescription)
            }
        }
    }
}


extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        if response.actionIdentifier == "remindLater" {
            let newDate = Date(timeInterval: 60, since: Date())
            scheduleNotification(at: newDate)
            
        }
    }
}
