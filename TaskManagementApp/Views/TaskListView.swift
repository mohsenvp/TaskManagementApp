//
//  ContentView.swift
//  TaskManagementApp
//
//  Created by Mohsen on 04/03/2024.
//

import SwiftUI
import CoreData

struct TaskListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var dateHolder: DateHolder
    
    @State var selectedFilter = TaskFilter.NonCompleted
    
    var body: some View{
        NavigationView{
            VStack{
                DateScroller()
                    .padding(.horizontal)
                    .environmentObject(dateHolder)
                Divider()
                ZStack{
                    if filteredTaskItems().count != 0{
                        List{
                            ForEach(filteredTaskItems()){ taskItem in
                                NavigationLink(destination: TaskEditView(passedTaskItem: taskItem, initialDate: taskItem.dueDate!)
                                    .environmentObject(dateHolder)){
                                    TaskCell(passedTaskItem: taskItem)
                                        .environmentObject(dateHolder)
                                }
                            }
                            .onMove(perform: moveItem)
                            .onDelete(perform: deleteItems)
                            .listRowSeparator(.hidden)
                            
                        }
                        .listRowBackground(Color.white)
                        .listRowSpacing(10)
                        
                    }else{
                        VStack(spacing: 10){
                            Image(systemName: "doc.plaintext")
                                .imageScale(.large)
                                .foregroundColor(.gray)
                                .padding(.top, 80)
                            Text("You've no new task")
                                .foregroundColor(.gray)
                                .font(.caption)
                            Spacer()
                        }
                        
                    }
                    
                    FloatingButton()
                        .environmentObject(dateHolder)
                        
                }
            }
            .navigationTitle("To Do List")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Picker("", selection: $selectedFilter.animation())
                    {
                        ForEach(TaskFilter.allFilters, id: \.self)
                        {
                            filter in
                            Text(filter.rawValue)
                        }
                    }
                }
            }
        }
    }
    
    private func filteredTaskItems() -> [TaskItem]{
        if selectedFilter == TaskFilter.Completed{
            return dateHolder.taskItems.filter{ $0.isCompleted()}
        }
        
        if selectedFilter == TaskFilter.NonCompleted{
            return dateHolder.taskItems.filter{ !$0.isCompleted()}
        }
        
        if selectedFilter == TaskFilter.OverDue{
            return dateHolder.taskItems.filter{ $0.isOverdue()}
        }
        
        return dateHolder.taskItems
    }
    
    private func moveItem(at sets:IndexSet,destination:Int){
        let itemToMove = sets.first!
        let items = dateHolder.taskItems
        
        if itemToMove < destination{
            var startIndex = itemToMove + 1
            let endIndex = destination - 1
            var startOrder = items[itemToMove].order
            while startIndex <= endIndex{
                items[startIndex].order = startOrder
                startOrder = startOrder + 1
                startIndex = startIndex + 1
            }
            items[itemToMove].order = startOrder
        }
        else if destination < itemToMove{
            var startIndex = destination
            let endIndex = itemToMove - 1
            var startOrder = items[destination].order + 1
            let newOrder = items[destination].order
            while startIndex <= endIndex{
                items[startIndex].order = startOrder
                startOrder = startOrder + 1
                startIndex = startIndex + 1
            }
            items[itemToMove].order = newOrder
        }
        
        do{
            try viewContext.save()
        }
        catch{
            print(error.localizedDescription)
        }
        
    }
    
    
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { filteredTaskItems()[$0] }.forEach(viewContext.delete)
            
            dateHolder.saveContext(viewContext)
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
