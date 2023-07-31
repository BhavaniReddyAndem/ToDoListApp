//
//  NotificationDelegate.swift
//  ToDoListPlanner
//
//  Created by Bhavani Reddy Navure on 7/31/23.
//
import UserNotifications
import Foundation

class NotificationDelegate: NSObject, UNUserNotificationCenterDelegate {
    // Handle notification presentation when the app is in the foreground
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound, .badge])
    }
    
    // Handle notification tap action when the app is in the foreground or background
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        // Handle the action based on the notification's identifier or other information
        completionHandler()
    }
}
