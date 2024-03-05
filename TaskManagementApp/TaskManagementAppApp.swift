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
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
