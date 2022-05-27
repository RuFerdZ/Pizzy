//
//  FavouritesList.swift
//  PizzaApplication
//
//  Created by Rusiru Fernando on 5/11/22.
//

import SwiftUI

struct FavouritesList: View {
    
    @Environment(\.managedObjectContext) var moc // this is used as we will be manipulating data in the context
    
    // fetch pizzas from core data where the `isfavorire` tag is true
    @FetchRequest(entity: Pizza.entity(), sortDescriptors: [], predicate: NSPredicate(format: "isFavourite = %d", true)) var favourites: FetchedResults<Pizza>
     
    var body: some View {
        // NavigationView  is used if there is a navigation to another page within the View
        NavigationView{
            VStack {
                if (favourites.isEmpty) {
                    // if there are no items on favorites list 
                    Text("No items")
                        .padding()
                        .foregroundColor(Color.gray)
                } else {
                    List(favourites, id: \.id) { favourite in
                        NavigationLink {
                            PizzaDetailView(pizza: favourite)
                        } label : {
                            HStack {
                                Image(uiImage: UIImage(data: favourite.image!)!)
                                    .resizable()
                                    .frame(width: 100, height: 100)
                                Text(favourite.name ?? "")
                                
                            }
                        }.swipeActions(edge: .trailing, allowsFullSwipe: false) {
                            // removes an item from the favourites list
                            Button {
                                favourite.isFavourite = false
                                try? moc.save()
                            } label: {
                                Label("Remove", systemImage: "trash")
                            }
                        }.tint(Color.red)
                    }
                    .listStyle(PlainListStyle())
                }
            }
            .navigationBarTitle("Favourites", displayMode: .inline)
        }
    }
}


struct FavouritesList_Previews: PreviewProvider {
    static var previews: some View {
        FavouritesList()
    }
}
