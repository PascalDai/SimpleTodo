//
//  CustomFilteringDataView.swift
//  SimpleTodo
//
//  Created by Pascal Dai on 2023/9/20.
//

import SwiftUI

struct CustomFilteringDataView<Content:View>: View {
    var content: ([Task],[Task]) -> Content
    @FetchRequest private var result: FetchedResults<Task>
    @Binding private var filterDate: Date
    init(filterDate: Binding<Date>,@ViewBuilder content:@escaping([Task],[Task])->Content){
        let calender = Calendar.current
        let startOfDay = calender.startOfDay(for: filterDate.wrappedValue)
        let endOfDay = calender.date(bySettingHour: 23, minute: 59, second: 59, of: startOfDay)!
        
        let predicate = NSPredicate(format: "date >= %@ AND date <= %@", argumentArray: [startOfDay,endOfDay])
        
        _result = FetchRequest(entity: Task.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Task.date, ascending: false)],predicate: predicate,animation:.easeInOut(duration: 0.25))
        
        self.content = content
        self._filterDate = filterDate
    }
    
    var body: some View {
        content(separeteTasks().0,separeteTasks().1)
            .onChange(of: filterDate) { newValue in
                /// Clearing Old Predicate
                result.nsPredicate = nil
                
                let calender = Calendar.current
                let startOfDay = calender.startOfDay(for: newValue)
                let endOfDay = calender.date(bySettingHour: 23, minute: 59, second: 59, of: startOfDay)!
                
                let predicate = NSPredicate(format: "date >= %@ AND date <= %@", argumentArray: [startOfDay,endOfDay])
            }
    }
    
    func separeteTasks() -> ([Task],[Task]) {
        let pendingTasks = result.filter { !$0.isCompleted }
        let completedTasks = result.filter { $0.isCompleted }
        
        return (pendingTasks,completedTasks)
    }
}

struct CustomFilteringDataView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
