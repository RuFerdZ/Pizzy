//
//  Keyboard+Extension.swift
//  PizzaApplication
//
//  Created by Rusiru Fernando on 5/18/22.
//

import Foundation
import SwiftUI
import UIKit

// extended view class to be able to use in all views
// used to hide keyboard on background tap gestures
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
