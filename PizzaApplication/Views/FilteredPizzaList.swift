//
//  FilteredPizzaList.swift
//  PizzaApplication
//
//  Created by Rusiru Fernando on 5/13/22.
//

import SwiftUI

struct FilteredPizzaList: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest var pizzas: FetchedResults<Pizza>
    
    // loads the pizzas according to its type as the tag changes
    init(tag: Int){
        if tag == 1 {
            _pizzas = FetchRequest<Pizza>(entity: Pizza.entity(), sortDescriptors: [], predicate: NSPredicate(format: "type BEGINSWITH %@", PizzaSelectionTypes.meat.rawValue))
        } else if tag == 2 {
            _pizzas = FetchRequest<Pizza>(entity: Pizza.entity(), sortDescriptors: [], predicate: NSPredicate(format: "type BEGINSWITH %@", PizzaSelectionTypes.veggie.rawValue))
        } else {
            _pizzas = FetchRequest<Pizza>(entity: Pizza.entity(), sortDescriptors: [])
        }
        
    }
    
    var body: some View {
        List(pizzas, id: \.id) { pizza in  // `\.id` identifies each item uniquely in a list
            // NavigationView  is used if there is a navigation to another page within the View
            NavigationLink {
                PizzaDetailView(pizza: pizza) // Custom view.
            } label: {
                HStack {
                    Image(uiImage: UIImage(data: pizza.image!)!)
                        .resizable()
                        .frame(width: 100, height: 100)
                    Text(pizza.name ?? "")
                }
            }
            .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                // swipe to delete a pizza
                Button {
                    moc.delete(pizza)
                    try? moc.save()
                } label: {
                    Label("Delete", systemImage: "trash")
                }
            }.tint(Color.red)
        }
    }
}
