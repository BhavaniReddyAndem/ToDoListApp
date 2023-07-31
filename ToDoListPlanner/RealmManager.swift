//
//  RealmManager.swift
//  TODOLIST
//
//  Created by Bhavani Reddy Navure on 6/27/23.
//

import Foundation
import RealmSwift
import UserNotifications

class RealmManager: ObservableObject {
    private(set) var localRealm: Realm?
    @Published private(set) var tasks: [Task] = []
    
    init() {
        openRealm()
        getTasks()
    }
    
    func openRealm() {
            do {
                let config = Realm.Configuration(schemaVersion: 4, migrationBlock: { migration, oldSchemaVersion in
                    if oldSchemaVersion < 4 {
                        // Perform migration actions for schema version 0 to 1
                        // Note: If you have no migration for version 1 to 2, you don't need to handle it here.

                        // Add the 'scheduledTime' property to the 'Task' object
                        migration.enumerateObjects(ofType: Task.className()) { oldObject, newObject in
                            newObject?["scheduledTime"] = Date()
                        }

                        // Add the 'isDeleted' property to the 'Task' object
                        migration.enumerateObjects(ofType: Task.className()) { oldObject, newObject in
                            newObject?["isDeleted"] = false
                        }
                    }
                })
                Realm.Configuration.defaultConfiguration = config

                localRealm = try Realm()
            } catch {
                print("Error opening Realm : \(error)")
            }
        }
    
    func addTask(taskTitle: String, scheduledTime: Date) {
        if let localRealm = localRealm {
            do {
                try localRealm.write {
                    let newTask = Task(value: ["title": taskTitle, "completed": false])
                    localRealm.add(newTask)
                    getTasks()
                    print("Added new task to Realm: \(newTask)")
                }
            } catch {
                print("Error adding task to Realm : \(error)")
            }
        }
    }
    
    
    func getTasks() {
        if let localRealm = localRealm {
            
            let allTasks = localRealm.objects(Task.self).sorted(byKeyPath: "completed")
            tasks = []
            allTasks.forEach { task in
                tasks.append(task)
            }
            
        }

    }
    
    func updateTask(id: ObjectId, completed: Bool) {
        if let localRealm = localRealm {
            do {
                let taskToUpdate = localRealm.objects(Task.self).filter(NSPredicate(format: "id == %@", id))
                guard !taskToUpdate.isEmpty else { return }
                
                try localRealm.write {
                    taskToUpdate[0].completed = completed
                    getTasks()
                    print("Updated the tasks with the id : \(id), Completed Status: \(completed)")
                }
            } catch {
                print("Error updating task \(id) to Realm: \(error)")
            }
        }
    }
    
    
    func deleteTask(id: ObjectId) {
        if let localRealm = localRealm {
            do {
                let taskToDelete = localRealm.objects(Task.self).filter(NSPredicate(format: "id == %@", id))
                guard let task = taskToDelete.first else { return }

                try localRealm.write {
                    task.isDeleted = true
                    print("Marked the task with id: \(id) as deleted")
                }
            } catch {
                print("Error deleting task with \(id) from Realm: \(error)")
            }
        }
    }
    
    func scheduleNotification(for task: Task) {
        guard let scheduledTime = task.scheduledTime else {
            return // If the task doesn't have a scheduled time, don't schedule a notification
        }
        
        let content = UNMutableNotificationContent()
        content.title = "Task Reminder"
        content.body = task.title
        content.sound = .default
        
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: scheduledTime)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        let identifier = task.id.stringValue // Use the task's ID as the unique identifier for the notification
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification for task \(task.id): \(error.localizedDescription)")
            } else {
                print("Notification scheduled for task \(task.id)")
            }
        }
    }



}
