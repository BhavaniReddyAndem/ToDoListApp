//
//  TaskDateView.swift
//  TodoApp
//
//  Created by Bhavani Reddy Navure on 7/21/23.
//

import SwiftUI

struct TaskDateView: View {

    @Binding var selectedDate: Date

    var body: some View {
        VStack(alignment: .leading) {
            Text("Time & Date")
                .font(.title3)
                .frame(maxWidth: .infinity, alignment: .leading)                        .foregroundColor(.black)

                .padding(.top, 20)

            DatePicker("", selection: $selectedDate, displayedComponents: [.date, .hourAndMinute])
                .foregroundColor(Color.purple.opacity(0.7))
                //.padding(.trailing, 30)
                .frame(width: 120, height: 40)
                .padding(.leading, 45)


        }
    }
}

struct TaskDateView_Previews: PreviewProvider {
    static var previews: some View {
        TaskDateView(selectedDate: .constant(Date()))
    }
}
