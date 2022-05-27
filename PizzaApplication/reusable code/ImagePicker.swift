//
//  ImagePicker.swift
//  PizzaApplication
//
//  Created by Rusiru Fernando on 5/13/22.
//

import SwiftUI
import Combine

// used to upload images into the application
struct ImagePicker: UIViewControllerRepresentable {
    @Binding var show: Bool   // holds the image selection screen show/hide state
    @Binding var image: Data  // holds the image
    
    // create ui image picker controller
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> some UIImagePickerController {
        let picker = UIImagePickerController()
        // set source as photo library
        picker.sourceType = .photoLibrary
        picker.delegate = context.coordinator
        return picker
    }
    
    
    // update ui image picker controller
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: UIViewControllerRepresentableContext<ImagePicker>) {
        // we wont be needing this
    }
    
    func makeCoordinator() -> Coordinator {
        return ImagePicker.Coordinator(child1: self)
    }
    
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var child: ImagePicker
        
        init(child1: ImagePicker){
            child = child1
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
            self.child.show.toggle()
        }
        
        // image picking and setting function
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]){
            let image = info[.originalImage] as! UIImage
            let data = image.jpegData(compressionQuality: 0.45)
            
            self.child.image = data!
            self.child.show.toggle()
        }
    }
}
