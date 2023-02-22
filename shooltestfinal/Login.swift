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
    @State var isSETINGView: Bool = false
    var body: some View {
        NavigationView{
                 ScrollView{
                     HStack{
                         Text("Welcome to Estaddel!")
                         Spacer()
                         Button {
                             isSETINGView.toggle()
                         } label: {
                             Image(systemName: "gearshape")
                                 .frame(width: 80, height: 80)
                         }

                     }
                     VStack{
                         Image(systemName: "person.circle")
                         
                             .resizable()
                             .frame(width: 145, height: 145)
                         // MARK: - title
                         
                         Text("Login")
                             .font(.title)
                         //                     }.padding(.horizontal)
                         ////                     Picker(selection: $isNewUser){
                         ////
                         ////                         Text("Login")
                         ////                             .tag(false)
                         ////                         Text("create Acount")
                         ////                             .tag(true)
                         ////                     } label: {
                         ////                     }.pickerStyle(.segmented)
                         //
                         //                     PhotosPicker(selection: $selection, maxSelectionCount: 1, matching: .images, preferredItemEncoding: .automatic){
                         //                         if let profileImage {
                         //                             Image(uiImage: profileImage)
                         //                                 .resizable()
                         //                                 .scaledToFill()
                         //                                 .frame(width:60 , height: 60)
                         //                                 .clipShape(Circle())
                         //                        }
                         ////                             else {
                         ////                             Image(systemName: "person.circle")
                         ////                                 .resizable()
                         ////                                 .scaledToFill()
                         ////                                 .frame(width:60 , height: 60)
                         ////
                         ////
                         ////                         }
                         //
                         //
                         //
                         //     //                    Image(systemName: "person.circle")
                         //     //                        .resizable()
                         //     //                        .scaledToFill()
                         //     //                        .frame(width: 60 , height:  60)
                         //                     }.padding(.top)
                         //                         .onChange(of: selection){ _ in for item in selection {
                         //                             Task{
                         //                                 if let data = try? await item.loadTransferable(type: Data.self){
                         //                                     profileImage = UIImage(data: data)
                         //                                 }
                         //                             }
                         //                         }
                         //
                         //                         }
                         //                       .isHidden(!isNewUser,remove:!isNewUser)
                         
                         
                         CustomInputField(imageName: "envelope",
                                          placeholderText: "Email",
                                          text: $email)
                             .padding()
                         //                     TextField("UserName" , text: $username)
                         //                         .padding()
                         
                         SecureField("Password" , text: $password)
                             .padding(.horizontal)
                             .foregroundColor(Color("Sage"))
                             .frame(width: 358, height: 50)
                             .overlay(
                                 RoundedRectangle(cornerRadius: 10)
                                     .stroke(.gray, lineWidth: 1))
                             .padding(.bottom, 8)

                     }
                         .padding()
                     Button {
                          print("DEBUG: button pressed")
                         isLoading.toggle()
                         DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                             
                             guard let location = locationManager.userLocation?.coordinate else {return}
                             
                             firebaseUserManager.logUserIn(email: email, password: password , location: location) { isSuccess in
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
                         Text(isNewUser ? "login" : "Log in")
                             .font(.headline)
                             .foregroundColor(.white)
                             .frame(width: 358, height: 48)
                             .background(Color("Sage"))
                             .mask(RoundedRectangle(cornerRadius: 10, style: .continuous))
                             
                             
                     }
//
//                     Text("Location user")
//                     Text("Lat:\(locationManager.userLocation?.coordinate.latitude ?? 0.0)")
//
//                     Text("Long:\(locationManager.userLocation?.coordinate.longitude ?? 0.0)")
                     
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
             .fullScreenCover(isPresented: $isSETINGView){
                Sitting()
             }
       
         }
         
     }



struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
            .preferredColorScheme(.dark)
            .environmentObject(FirebaseUserManager())
    }
}


