//
//  DataController.swift
//  PizzaApplication
//
//  Created by Rusiru Fernando on 5/11/22.
//

import Foundation
import CoreData


// core-data data controller
class DataController: ObservableObject {
    
    // use PizzaAppDataModels core-data model
    let container = NSPersistentContainer(name: "PizzaAppDataModels")
    
    // initializer to load the selected data model 
    init() {
        container.loadPersistentStores{description, error in
            if let error = error {
                print("Error Loading Core Data: \(error.localizedDescription)")
            }
        }
    }
}
