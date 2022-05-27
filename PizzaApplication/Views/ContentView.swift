//
//  ContentView.swift
//  PizzaApplication
//
//  Created by Rusiru Fernando on 5/11/22.
//

import SwiftUI

struct ContentView: View {

    var body: some View {
        // tab view to distinguish the 2 main screens: pizza list and favourites list
        TabView {
            PizzaList()
                .tabItem {
                    Label("Pizza List", systemImage: "list.dash")
                }
            FavouritesList()
                .tabItem {
                    Label("Favourites List", systemImage: "star.fill")
                }
        }
    }
}
