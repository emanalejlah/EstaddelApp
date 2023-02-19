//
//  FirebaseRealEstateManager.swift
//  shooltestfinal
//
//  Created by eman alejilah on 27/07/1444 AH.
//


import SwiftUI
import PhotosUI
import FirebaseFirestoreSwift
import Firebase
import FirebaseStorage
import FirebaseFirestore
import CoreLocation

class FirebaseRealEstateManager: NSObject, ObservableObject{
    
    
    @Published var realEstates: [RealEstate] = []
   
      
      
      
      let auth: Auth
      let firestore: Firestore
      let storage: Storage
      
      override init() {
          self.auth = Auth.auth()
          self.firestore = Firestore.firestore()
          self.storage = Storage.storage()
          super.init()
          fetchRealEstates()
      }
    
    func fetchRealEstates(){
        firestore.collection("realEstates").addSnapshotListener { querySnapshot, error in
            if let error = error {
                print("Dubug: error whil fetching all real estate\(error)")
                return
            }
//            print ("DUBUG: snapshot\(querySnapshot)")
          guard let realEstates = querySnapshot?.documents.compactMap({try? $0.data(as:RealEstate.self )}) else {return}
            
//            print ("DUBUG: snapshot\(realEstates.map({$0.id}))")
            self.realEstates = realEstates
            //    guard (querySnapshot?.documents.compactMap({try? $0.data(as:RealEstate.self )})) != nil else {return}
        }
    }
    
    func fetchOwnarDetial(userId: String, comletion: @escaping((User) ->()) ){
        firestore.collection("users").document(userId).addSnapshotListener { documentSnapshot, error in
            if let error = error{
                print("DEBUG: while geeting user info \(error)")
                return
            }
            guard let userOwner = try?  documentSnapshot?.data(as:User.self) else {return}
            comletion(userOwner)
        }
        
    }

    
    func addRealEstate(realEstate:RealEstate, images:[UIImage] , Completion: @escaping ((Bool) -> ()  )){
        var realEstate = realEstate
        
        self.uploadImagesToStorage(images: images) { imageUrlString in
            realEstate.images = imageUrlString
            try?  self.firestore.collection("realEstates").document(realEstate.id).setData(from: realEstate)
            Completion(true)
        }

     
   
        
    }
    
    func uploadImagesToStorage(images: [UIImage], onCompletion: @escaping( ([String]) -> () )) {
        print("DEBUG: ENTRING UPLOUDIMAGE TO STROGE FUNC")
        var imageUrlStrings: [String] = []

        guard let userId = auth.currentUser?.uid else { return }

        for image in images {
            print("DEBUG: ENTRING PHOTO LOOP")
            
            let imageId: String = UUID().uuidString
            guard let imageData = image.jpegData(compressionQuality: 0.4) else { return }
            print("DEBUG: CONVRET TO DATA")
            let refStorage = storage.reference(withPath: userId + "/" + imageId)

            refStorage.putData(imageData, metadata: nil) { storageMetaData, error in
                if let error = error{
                    print("DEBUG: Error while uploading Photo \(error)")
                    return
                }
                
            
                print("DEBUG: SUCCEFULY UPLODING PHOTO")
                refStorage.downloadURL { imageUrl, error in
                    if let error = error{
                        print("DEBUG: Error while downloading Photo \(error)")
                        return
                    }
                    print("DEBUG: SUCCEFULY DOWNLOWD PHOTO")
                    guard let imageUrlString = imageUrl?.absoluteString else { return }
                    imageUrlStrings.append(imageUrlString)
                    onCompletion(imageUrlStrings)
                }
            }
        }
    }
      
}

