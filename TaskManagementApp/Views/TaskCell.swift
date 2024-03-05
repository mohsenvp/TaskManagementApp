//
//  TaskCell.swift
//  TaskManagementApp
//
//  Created by Mohsen on 05/03/2024.
//

import SwiftUI

struct TaskCell: View
{
    @EnvironmentObject var dateHolder: DateHolder
    @ObservedObject var passedTaskItem: TaskItem
    
    var body: some View
    {
        HStack
        {
            CheckBoxView(passedTaskItem: passedTaskItem)
                .environmentObject(dateHolder)
            
            VStack(alignment:.leading) {
                Text(passedTaskItem.name ?? "")
                Text(passedTaskItem.desc ?? "")
                    .font(.footnote)
                    .foregroundColor(.gray)
                    
            }.padding(.horizontal)
            
            if !passedTaskItem.isCompleted() && passedTaskItem.scheduleTime
            {
                Spacer()
                Text(passedTaskItem.dueDateTimeOnly())
                    .font(.footnote)
                    .foregroundColor(passedTaskItem.overDueColor())
                    .padding(.horizontal)
            }
        }
    }
}

struct TaskCell_Previews: PreviewProvider {
    static var previews: some View {
        TaskCell(passedTaskItem: TaskItem())
    }
}
