//
//  Login.swift
//  shooltestfinal
//
//  Created by eman alejilah on 26/07/1444 AH.
//


import SwiftUI
import PhotosUI
import FirebaseFirestoreSwift
import Firebase

struct Login: View {
    @State var isNewUser:Bool = true
    @State var email: String = ""
    @State var password: String = ""
    @State var username:String = ""
    @State var profileImage: UIImage?
    @State var selection: [PhotosPickerItem] = []
    @EnvironmentObject var firebaseUserManager : FirebaseUserManager
    @State var isLoading: Bool = false
    @State var isShowinHomeView: Bool = false
    @StateObject var locationManager = LocationManager()
    @Environment(\.presentationMode) private var presentationMode
    
    var body: some View {
        NavigationView{
                 ScrollView{
                     HStack{
                         Text("welcome to my app")
                         Spacer()
                         
                     }.padding(.horizontal)
//                     Picker(selection: $isNewUser){
//
//                         Text("Login")
//                             .tag(false)
//                         Text("create Acount")
//                             .tag(true)
//                     } label: {
//                     }.pickerStyle(.segmented)
                     
                     PhotosPicker(selection: $selection, maxSelectionCount: 1, matching: .images, preferredItemEncoding: .automatic){
                         if let profileImage {
                             Image(uiImage: profileImage)
                                 .resizable()
                                 .scaledToFill()
                                 .frame(width:60 , height: 60)
                                 .clipShape(Circle())
                        }
//                             else {
//                             Image(systemName: "person.circle")
//                                 .resizable()
//                                 .scaledToFill()
//                                 .frame(width:60 , height: 60)
//
//
//                         }
                         
                         
                         
     //                    Image(systemName: "person.circle")
     //                        .resizable()
     //                        .scaledToFill()
     //                        .frame(width: 60 , height:  60)
                     }.padding(.top)
                         .onChange(of: selection){ _ in for item in selection {
                             Task{
                                 if let data = try? await item.loadTransferable(type: Data.self){
                                     profileImage = UIImage(data: data)
                                 }
                             }
                         }
                             
                         }
                       .isHidden(!isNewUser,remove:!isNewUser)
                     
                     
                     TextField("Email" , text: $email)
                         .padding()
                         .overlay {
                             RoundedRectangle(cornerRadius: 5)
                                 .stroke(Color.white, lineWidth: 0.4)
                         }
                         .padding()
//                     TextField("UserName" , text: $username)
//                         .padding()
                         .overlay {
                             RoundedRectangle(cornerRadius: 5)
                                 .stroke(Color.white, lineWidth: 0.4)
                         }
                     
                     SecureField("Password" , text: $password)
                         .padding()
                         .overlay {
                             RoundedRectangle(cornerRadius: 5)
                                 .stroke(Color.white, lineWidth: 0.4)
                         }
                         .padding()
                     Button {
                          print("DEBUG: button pressed")
                         isLoading.toggle()
                         DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                             

                             firebaseUserManager.logUserIn(email: email, password: password) { isSuccess in
     //                            print("DEBUG: succes all")
                                 if isSuccess {
                                     isLoading.toggle()
//                                   isShowinHomeView.toggle()
                                     presentationMode.wrappedValue.dismiss()
                                  
                                     
                                 }else{
                                     isLoading.toggle()
                                 }
                                 
                             }
                            
         //
                         }
     //      Auth.auth().createUser(withEmail: email,   password: password)

                     } label: {
                         Text(isNewUser ? "create Acount" : "log in")
                             .foregroundColor(.white)
                             .frame(width: 300 , height: 50)
                             .background(Color.blue.cornerRadius(5))
                             
                     }
                     
                     Text("Location user")
                     Text("Lat:\(locationManager.userLocation?.coordinate.latitude ?? 0.0)")

                     Text("Long:\(locationManager.userLocation?.coordinate.longitude ?? 0.0)")
                     
     //                NavigationLink (destination: Login(), label: {
     //                  Text("have accoun")
     //                    .foregroundColor(.white)
     //                    .font(.headline)
     //                    .padding(30)
     //                })



                     
                     
                 }
                 .navigationTitle("")
                 .toolbar{
                     ToolbarItem(placement: .navigationBarLeading){
                         Button {
                             presentationMode.wrappedValue.dismiss()
                         } label: {
                             Text("DISSMIS")
                         }
                         
                     }
                 }
             }.overlay {
                 ZStack {
                     Color.black.opacity(0.4)
                         .ignoresSafeArea()
                     VStack(spacing: 20){
                         ProgressView()
                             .progressViewStyle(.circular)
                             .tint(.white)
                             .scaleEffect(2)
                             Text("please wait...")
                     }
                 }   .isHidden(!isLoading,remove:!isLoading)
                    
             }
//             .fullScreenCover(isPresented: $isShowinHomeView){
//                 HomeView()
//             }
       
         }
         
     }



struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
            .preferredColorScheme(.dark)
            .environmentObject(FirebaseUserManager())
    }
}


