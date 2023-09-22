//
//  SimpleTodoApp.swift
//  SimpleTodo
//
//  Created by Pascal Dai on 2023/9/20.
//

import SwiftUI

@main
struct SimpleTodoApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
