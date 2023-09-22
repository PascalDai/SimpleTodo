//
//  ContentView.swift
//  SimpleTodo
//
//  Created by Pascal Dai on 2023/9/20.
//

import SwiftUI
import CoreData

struct ContentView: View {
    var body: some View {
        NavigationStack {
            Home()
                .navigationTitle("To-Do")
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
