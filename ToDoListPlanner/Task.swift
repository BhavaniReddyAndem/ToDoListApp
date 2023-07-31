//
//  Task.swift
//  TODOLIST
//
//  Created by Bhavani Reddy Navure on 6/27/23.
//

import Foundation
import RealmSwift

class Task: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var title = ""
    @Persisted var completed = false
    @Persisted var scheduledTime: Date? // New property for the scheduled time

}
