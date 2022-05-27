//
//  NewPizzaView.swift
//  PizzaApplication
//
//  Created by Rusiru Fernando on 5/11/22.
//

import SwiftUI


struct NewPizzaView: View {

    @Environment(\.presentationMode) var presentationMode // used since the view is presented by another view
    @Environment(\.managedObjectContext) var moc      // this context is used if manipulating any data in the application
        
    // attributes of a Pizza as state variables
    @State private var name = ""
    @State private var ingredients = "\u{2022} "
    @State private var image: Data = .init(count: 0)
    @State private var show = false
    @State private var type: PizzaSelectionTypes = .veggie
    
    var body: some View {
        // NavigationView  is used if there is a navigation to another page within the View
        NavigationView {
            ScrollView {
                ZStack {
                    Color.gray
                        .opacity(0.2)
                    VStack {
                        Section {
                            // text field to get the name of the pizza
                            TextField("Enter Pizza Name", text: $name)
                                .textFieldStyle(.roundedBorder)
                            
                            // text editor to get the ingredients
                            TextEditor(text: $ingredients)
                                .frame(height: 200)
                                .background(Color.white)
                                // used to add a bullet point at the beginning of each new line
                                .onChange(of: ingredients) { [ingredients] newIngredient in
                                    if newIngredient.suffix(1) == "\n" && newIngredient > ingredients {
                                        self.ingredients.append("\u{2022} ")
                                    }
                                }
                        }.onTapGesture {
                            // used to hide keyboard on background tap
                            self.hideKeyboard()
                        }
                        
                        
                        Section {
                            // displays the image upload button as an Image
                            if (self.image.count != 0) {
                                // if there is already an image show the image
                                Button(action: {
                                    self.show.toggle()
                                }) {
                                    Image(uiImage: UIImage(data: self.image)!)
                                        .renderingMode(.original)
                                        .resizable()
                                        .frame(width: 200, height: 200)
                                        .cornerRadius(6)
                                }
                            } else {
                                // If an image is not already uploaded, show default image
                                Button(action: {
                                    self.show.toggle()
                                }) {
                                    Image(systemName: "photo.fill")
                                        .font(.system(size: 100))
                                        .foregroundStyle(.blue)
                                }
                            }
                        
                            Text("Pizza Type").textFieldStyle(.roundedBorder).padding(.top, 15)
                            // picker to choose the pizza tupe
                            Picker("Pizza Type", selection: $type){
                                Text("Meat").tag(PizzaSelectionTypes.meat)
                                Text("Veggie").tag(PizzaSelectionTypes.veggie)
                            }.pickerStyle(.segmented).textFieldStyle(.roundedBorder)
                        }
                        
                        Spacer()
                    }
                    .padding()
                }
            }.ignoresSafeArea(.keyboard)
            .navigationTitle("New Pizza")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem {
                    // button used to add a new pizza
                    Button {
                        // setting up the pizza object
                        let pizza = Pizza(context: moc)
                        
                        pizza.id = UUID()
                        pizza.name = name
                        pizza.ingredients = ingredients
                        pizza.image = image
                        pizza.type = type.rawValue
                        
                        // saves the pizza object using core data
                        try? moc.save()
                        presentationMode.wrappedValue.dismiss() // closes the view once a pizza is added
                    } label: {
                        Text("Add Pizza")
                            .foregroundColor((self.name.count>0 && self.image.count>0 && self.ingredients.count>0) ? Color.blue: Color.gray
                            )
                    }.disabled(
                        // keep the add button disabled until all mandatory fields are filled.
                        self.name.isEmpty || self.ingredients.isEmpty ||  self.image.isEmpty
                    )
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    // used to close the add pizza view
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Cancel")
                    }
                }
            }
        }
        .sheet(isPresented: self.$show, content: {
            // show image picker upon clicking the image
            ImagePicker(show: self.$show, image: self.$image)
        })
    }
}

struct NewPizzaView_Previews: PreviewProvider {
    static var previews: some View {
        NewPizzaView()
    }
}

