//
//  PizzaList.swift
//  PizzaApplication
//
//  Created by Rusiru Fernando on 5/11/22.
//

import SwiftUI

struct PizzaList: View {
    
    @State var category = 0                       // this controls the pizza category the user uses to filter
    @State var isAddPizzaScreenShowing = false    // this handles the state of the add pizza screen/pop to be shown or not
    @Environment(\.managedObjectContext) var moc  // this context is used if manipulating any data in the application
    
    var body: some View {
        // NavigationView  is used if there is a navigation to another page within the View
        NavigationView {
            VStack {
                Picker("Pizzas", selection: $category) {
                    Text("All🍕").tag(0) // tag is to identify the tab category
                    Text("Meat🥩").tag(1)
                    Text("Veggie🥦").tag(2)
                }
                .pickerStyle(.segmented)
                // passing the relavant category to the actual list of pizzas to be displayed
                FilteredPizzaList(tag: category)
                .listStyle(PlainListStyle()) // PlainListStyle
            }
            .navigationBarTitle("Pizzas", displayMode: .inline)
            .sheet(isPresented: $isAddPizzaScreenShowing, content: {
                // show/hide add pizza view according to the binded variable
                NewPizzaView()
            })
            .toolbar {
                ToolbarItem {
                    Button {
                        // toggle is used to control whether the add pizza screen is visible or not
                        isAddPizzaScreenShowing.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
}
