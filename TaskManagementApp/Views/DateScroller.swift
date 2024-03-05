//
//  DateScroller.swift
//  TaskManagementApp
//
//  Created by Mohsen on 05/03/2024.
//

import SwiftUI

struct DateScroller: View {
    @EnvironmentObject var dateHolder: DateHolder
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View{
        HStack{
            Spacer()
            Button(action: moveBack){
                Image(systemName: "arrow.left.circle")
                    .imageScale(.large)
            }
            Text(dateFormatted())
                .font(.title)
                .padding(10)
                .frame(maxWidth: .infinity)
            Button(action: moveForward){
                Image(systemName: "arrow.right.circle")
                    .imageScale(.large)
            }
        }
    }
    
    func dateFormatted() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd LLL yy"
        return dateFormatter.string(from: dateHolder.date)
    }
    
    func moveBack(){
        withAnimation{
            dateHolder.moveDate(-1, viewContext)
        }
    }
    
    func moveForward(){
        withAnimation{
            dateHolder.moveDate(1, viewContext)
        }
    }
}

struct DateScroller_Previews: PreviewProvider {
    static var previews: some View {
        DateScroller()
    }
}
