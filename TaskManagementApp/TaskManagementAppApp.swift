//
//  TaskManagementAppApp.swift
//  TaskManagementApp
//
//  Created by Mohsen on 04/03/2024.
//

import SwiftUI

@main
struct TaskManagementAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            
            let context = persistenceController.container.viewContext
            let dateHolder = DateHolder(context)
            
            TaskListView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(dateHolder)
        }
    }
}
