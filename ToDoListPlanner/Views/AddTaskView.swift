//
//  AddTaskView.swift
//  TODOLIST
//
//  Created by Bhavani Reddy Navure on 6/27/23.
//

import SwiftUI

struct AddTaskView: View {
    @EnvironmentObject var realmManager: RealmManager
    @State private var title: String = ""
    @State private var selectedDate = Date()
    


    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Create a New Task")
                .font(.title3).bold()
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(.black)
            TextField("Enter your task Here", text: $title)
                .textFieldStyle(.roundedBorder)
                .foregroundColor(.gray)

            
            TaskDateView(selectedDate: $selectedDate)
            
            Button {
                if title != "" {
                    realmManager.addTask(taskTitle: title, scheduledTime: selectedDate)
                }
                dismiss()
            } label: {
                Text("Add Task")
                    .foregroundColor(.white)
                    .padding()
                    .padding(.horizontal)
                    .background(Color("DarkPurple"))
                    .cornerRadius(30)
            }
            Spacer()
        }
        .padding(.top, 40)
        .padding(.horizontal)
        .background(Color(.white))
        
    }
}

struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskView()
            .environmentObject(RealmManager())
    }
}
