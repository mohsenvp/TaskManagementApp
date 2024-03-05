//
//  DropViewDelegate.swift
//  TaskManagementApp
//
//  Created by Mohsen on 05/03/2024.
//

import SwiftUI

struct DropViewDelegate: DropDelegate{
    
    let destinationItem: String
    @Binding var items: [String]
    @Binding var draggedItem: String?
    
    func dropUpdated(info: DropInfo) -> DropProposal? {
        return DropProposal(operation: .move)
    }
    
    func performDrop(info: DropInfo) -> Bool {
        draggedItem = nil
        return true
    }
    
    func dropEntered(info: DropInfo) {
        if let draggedItem{
            let fromIndex = items.firstIndex(of: draggedItem)
            if let fromIndex{
                let toIndex = items.firstIndex(of: destinationItem)
                if let toIndex, fromIndex != toIndex{
                    withAnimation {
                        self.items.move(fromOffsets: IndexSet(integer: fromIndex), toOffset: (toIndex > fromIndex ? (toIndex + 1) : toIndex))
                    }
                }
            }
        }
    }
    
}
