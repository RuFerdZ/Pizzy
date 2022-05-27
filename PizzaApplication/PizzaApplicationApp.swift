//
//  PizzaApplicationApp.swift
//  PizzaApplication
//
//  Created by Rusiru Fernando on 5/11/22.
//

import SwiftUI

@main
struct PizzaApplicationApp: App {
    
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}

