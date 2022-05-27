//
//  PizzaSelectionTypes.swift
//  PizzaApplication
//
//  Created by Rusiru Fernando on 5/11/22.
//

import Foundation


// represent the enumertation of pizza selection types
enum PizzaSelectionTypes: String, CaseIterable, Identifiable {
    case meat, veggie
    var id: Self {self}
}
