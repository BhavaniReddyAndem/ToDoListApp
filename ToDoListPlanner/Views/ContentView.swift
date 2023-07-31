//
//  ContentView.swift
//  TODOLIST
//
//  Created by Bhavani Reddy Navure on 6/27/23.
//

import SwiftUI
import UserNotifications

struct ContentView: View {
    @StateObject var realmManager = RealmManager()
    var notificationDelegate = NotificationDelegate()

    @State private var showAddTaskView = false
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            TasksView()
                .environmentObject(realmManager)
            AddButton()
                .padding()
                .onTapGesture {
                    showAddTaskView.toggle()
                }
        }
        .sheet(isPresented: $showAddTaskView) {
            AddTaskView()
                .environmentObject(realmManager)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .background(Color(.white))
        .onAppear {
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
                if granted {
                    print("User granted notification authorization.")
                } else {
                    print("User denied notification authorization.")
                }
            }
            
            UNUserNotificationCenter.current().delegate = notificationDelegate
        }
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
