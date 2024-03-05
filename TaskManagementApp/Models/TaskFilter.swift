//
//  TaskFilter.swift
//  TaskManagementApp
//
//  Created by Mohsen on 05/03/2024.
//

import SwiftUI

enum TaskFilter: String{
    static var allFilters: [TaskFilter]
    {
        return [.NonCompleted,.Completed,.OverDue,.All]
    }
    
    case All = "All"
    case NonCompleted = "To Do"
    case Completed = "Completed"
    case OverDue = "Overdue"
}
