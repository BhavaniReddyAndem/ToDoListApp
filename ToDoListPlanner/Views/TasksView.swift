//
//  TasksView.swift
//  TODOLIST
//
//  Created by Bhavani Reddy Navure on 6/27/23.
//

import SwiftUI

struct TasksView: View {
    @EnvironmentObject var realmManager: RealmManager
    @State private var shouldUpdateTasks = false // Add a state variable to trigger task updates
    
    var body: some View {
        VStack {
            // ... (your existing code)

            if realmManager.tasks.count > 0 {
                List {
                    ForEach(realmManager.tasks, id: \.id) { task in
                        if !task.isInvalidated && !task.isFrozen {
                            TaskRow(task: task.title, completed: task.completed, scheduledTime: task.scheduledTime )
                                .onTapGesture {
                                    realmManager.updateTask(id: task.id, completed: !task.completed)
                                    shouldUpdateTasks.toggle() // Toggle the state to trigger an update
                                }
                        }
                    }
                    .onDelete { indexSet in
                        for index in indexSet {
                            let taskToDelete = realmManager.tasks[index]
                            realmManager.deleteTask(id: taskToDelete.id)
                        }
                        shouldUpdateTasks.toggle() // Toggle the state to trigger an update
                    }
                    .listRowSeparator(.hidden)
                }
                .scrollContentBackground(.hidden)
            }

            Spacer()
        }
        .padding(.top, 40)
        .padding(.horizontal)
        .background(Color("LightPurple"))
        .onChange(of: shouldUpdateTasks) { _ in
            // This onChange modifier will trigger an update for the list when shouldUpdateTasks changes
        }
    }
}


struct TasksView_Previews: PreviewProvider {
    static var previews: some View {
        TasksView()
            .environmentObject(RealmManager())
    }
}
