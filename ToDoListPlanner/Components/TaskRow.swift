//
//  TaskRow.swift
//  TODOLIST
//
//  Created by Bhavani Reddy Navure on 6/27/23.
//

import SwiftUI

struct TaskRow: View {
    var task: String
    var completed: Bool
    var scheduledTime: Date? // New property for scheduled time

    
    var body: some View {
        HStack(alignment: .center) {
                Image(systemName: completed ? "checkmark.circle" : "circle")
                    .background(Color("DarkPurple").opacity(0.4))
                    .clipShape(Circle())
                
            VStack(alignment: .leading) {
                    Text(task)
                    if let scheduledTime = scheduledTime {
                        Text("Scheduled Time: \(formattedTime(scheduledTime))")
                            .foregroundColor(.black)
                            .font(.caption)
                    }
                }
            }
        
        }
    
    private func formattedTime(_ date: Date) -> String {
            print(scheduledTime)
            let formatter = DateFormatter()
            formatter.dateStyle = .none
            formatter.timeStyle = .short
            return formatter.string(from: date)
        }
}

struct TaskRow_Previews: PreviewProvider {
    static var previews: some View {
        TaskRow(task: "Do laundry", completed: true, scheduledTime: Date())
    }
}
