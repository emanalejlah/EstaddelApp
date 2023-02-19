//
//  FirebaseUserManager.swift
//  shooltestfinal
//
//  Created by eman alejilah on 26/07/1444 AH.
//

import SwiftUI
import PhotosUI
import FirebaseFirestoreSwift
import Firebase
import FirebaseStorage
import FirebaseFirestore
import CoreLocation

class FirebaseUserManager: NSObject, ObservableObject{
    
  @Published var user: User = .init()
    
    
    
    let auth: Auth
    let firestore: Firestore
    let storage: Storage
    
    override init() {
        self.auth = Auth.auth()
        self.firestore = Firestore.firestore()
        self.storage = Storage.storage()
        super.init()
        fetchUser()
    }
    
    func fetchUser(){
        guard let userId = auth.currentUser?.uid else {return}
        firestore.collection("users").document(userId).getDocument { documentSnapshot, error in
            if let error = error {
                print("DEBUG: error while fetching user info \(error.localizedDescription)")
               return
            }
            guard let user = try? documentSnapshot?.data(as: User.self) else {return}
            self.user = user
        }
        
    }
    
    func updateUserName(username: String, completion: @escaping ((Bool) -> ())){
        self.user.username = username
        try? self.firestore.collection("users").document(self.user.id).setData(from:user, merge: true){ error in
            if let error = error {
                print("DEBUG: error while updet user name \(error.localizedDescription)")
                completion(false)
            }
            completion(true)
        }
        
    }
    
    func updatePhoneNumber(phoneNumber: String, completion: @escaping ((Bool) -> ())){
        self.user.phoneNumber = phoneNumber
        try? self.firestore.collection("users").document(self.user.id).setData(from:user, merge: true) { error in
            if let error = error {
                print("DEBUG: error while updet phone nummber \(error.localizedDescription)")
                completion(false)
            }
            completion(true)
        }
    }
    
    func logOut(completion: @escaping ((Bool) -> ())){
        do {
            try auth.signOut()
            self.user = .init()
            completion(true)
        }catch{
            print("\(error)")
            completion(false)
        }
    }
    
    
    func logUserIn(email: String, password: String, completion: @escaping ((Bool) -> ())){
        auth.signIn(withEmail: email, password: password){ _, error in
            if let error = error {
                print("DEBUG: error while loggin user in \(error.localizedDescription)")
                completion(false)
            }
            completion(true)
        }
     
    }
    
    func createNewUser(email: String, password: String, username: String, profileImage:UIImage?,
                       location: CLLocationCoordinate2D ,  completion: @escaping(   (Bool) -> ()  )){
        print("DEBUG: enntring creatnewUser")
        
        auth.createUser(withEmail: email, password: password) { authResult, error in
            if let error = error{
                print("DEBUG: error while creating account \(error.localizedDescription)")
                return
            }
            print("DEBUG: Sucess creating account")
            guard let userId = authResult?.user.uid else {return}
            
//            خاص لبروفايل ايمج
            
            self.uploadProfileImageToStorge(userId: userId, profileImage: profileImage) { profileImageUrlString in
                
                print("DEBUG: succes getting profileImageUrlString after escaping ")
                
                let user = User(id: userId , profileImageUrl: profileImageUrlString, favoriteRealEstate: [], realEstates: [], phoneNumber:"", email: email, username: username, isVerified: false,
                                
                                
                                dayTimeAvailability: [.init(day: .friday, fromTime: Date(), toTime: Date())],
                                location: location)
                try? self.firestore.collection("users").document(userId).setData(from: user)
                print("DEBUG: succes storing profileimageUrl in user object ")
                
                completion(true)
            }
            
            
            
            
            
//
//            let user = User(id: userId , profileImageUrl: "", favoriteRealEstate: [], realEstates: [], phoneNumber:"", email: email, username: username, isVerified: false, dayTimeAvailability: [.init(day: .friday, fromTime: Date(), toTime: Date())], location: .init(latitude: 0, longitude: 0))
//            try? self.firestore.collection("users").document(userId).setData(from: user)
//            completion(true)
        }
    }
    
    func uploadProfileImageToStorge(userId: String, profileImage: UIImage?, completion: @escaping ((String) -> ())) {
        print("DEBUG: enntring uploadProfileImageToStorge ")
//        uuidstring for spechal id for every user
        let profileImageId = UUID().uuidString
        
        if let profileImage{
//            تحويل بروفايل image من uiimage الى data(image data)
            guard let imageData = profileImage.jpegData(compressionQuality: 0.5) else {return}
//            طريقه التخزين في ال storge in databaese
            let ref = storage.reference(withPath: userId + "/" + profileImageId)
//  "/" معناها نسوي ملف بال storge
            ref.putData(imageData, metadata: nil) { StorageMetadata, error in
                if let error = error{
                    print("DEBUG: error while uploading profile image \(error.localizedDescription)")
                    return
                }
                print("DEBUG: success upload photo to storge")
                ref.downloadURL { imageUrl, error in
                    if let error = error{
                        print("DEBUG: error while downloading image url \(error.localizedDescription)")
                        return
                    }
                    print("DEBUG: getting imageURL")
                    guard let profileImageUrlString = imageUrl?.absoluteString else {return}
                    completion(profileImageUrlString)

                }
                

            }
        }
        
    
    }
    
}


