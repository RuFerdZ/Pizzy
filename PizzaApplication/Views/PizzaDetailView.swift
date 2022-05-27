//
//  PizzaDetailView.swift
//  PizzaApplication
//
//  Created by Rusiru Fernando on 5/11/22.
//

import SwiftUI

struct PizzaDetailView: View {

    let pizza: Pizza
    
    @Environment(\.managedObjectContext) var moc // this is used as we will be manipulating data in the context
    
    @State private var isFavourite: Bool // state variable that holds/shows whether a pizza is a favourite or not
    
    // the constructor will set the selected pizza into the pizza details view
    init(pizza: Pizza) {
        self.pizza = pizza
        self.isFavourite = pizza.isFavourite
    }

    var body: some View {
        GeometryReader { reader in // to get the the coordinate space/space of the entire screen
            VStack(alignment: .leading) {
                // displays the image of the pizza
                Image(uiImage: UIImage(data: pizza.image!)!)
                    .resizable()
                    .frame(width: reader.size.width, height: 200)
                // displays the pizza name
                Text(pizza.name ?? "")
                    .padding()
                    .font(.title)
                // displays the ingredients of the pizza
                Text(pizza.ingredients ?? "")
                    .padding()
                // button used to favourite or unfavourite a pizza
                Button {
                    // toggle the isFavourite boolean value
                    isFavourite.toggle()
                    pizza.isFavourite = isFavourite
                    
                    // save the updated pizza object using core data
                    try? moc.save()
                } label: {
                    HStack {
                        // add/remove toggle depending on the current state
                        Text(isFavourite ? "Remove from Favourites" : "Add to Favourites")
                        Image(systemName: "star.fill")
                    }.foregroundColor(isFavourite ? .white : .red)
                        .padding()
                        .background(isFavourite ? .red : .white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 0)
                                .stroke(Color.red, lineWidth: 3)
                        )
                    
                }
                .frame(maxWidth: .infinity)
            }
        }
    }
}
