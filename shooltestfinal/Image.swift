//
//  ImagePicker.swift
//  Image Picker Demo
//
//  Created by eman alejilah on 07/04/1444 AH.
//

//import Foundation
//import UIKit
//import SwiftUI
//// Struct تعبر زي الجسر اللي تربط
//// swift ui and uikit عشان اختيار صوره
//struct ImagePicker: UIViewControllerRepresentable {
//    @Binding var selectedImage: UIImage?
//    @Binding var isPickerShowing: Bool
//    func makeUIViewController(context: Context) -> some UIViewController {
//        
//        let imagePicker = UIImagePickerController()
////        shose هنا نختار السورس اللي نضيف منه الصور من الكاميرا مباشرة او libarary
//        imagePicker.sourceType = .photoLibrary
//        imagePicker .delegate = context.coordinator
//        // object that can receive uIImageController events
//        return imagePicker
//        
//    }
//    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
//        
//    }
//    func makeCoordinator() -> Coordinator {
//        return Coordinator(self)
//    }
//}
//
//class Coordinator: NSObject,UIImagePickerControllerDelegate , UINavigationControllerDelegate{
//    var parent: ImagePicker
//    init(_ picker: ImagePicker){
//        self.parent = picker
//    }
//    
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
////        run the code when the user has selected an image
//        print("image selected")
//        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
//            // we were able to get the image
//            DispatchQueue.main.async{
//                self.parent.selectedImage = image
//
//                
//            }
//        }
//    
//        
//      // Dismiss the picker
//        parent.isPickerShowing = false
//    }
//    
//    
//    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//        // run code when the user has cancelled the picker ui
//        print("canacelled")
//        // Dismiss the picker
//          parent.isPickerShowing = false
//    }
//}
