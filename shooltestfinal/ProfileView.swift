//
//  ProfileView.swift
//  shooltestfinal
//
//  Created by eman alejilah on 26/07/1444 AH.
//

import SwiftUI
import SDWebImageSwiftUI
import MapKit
import Firebase

struct ProfileView: View {
    @EnvironmentObject var firebaseUserManager : FirebaseUserManager
    @State var isLoading: Bool = false
//    for back step for logout
    @Environment(\.presentationMode) private var presentationMode
    
    var body: some View {
        
        NavigationView{
            
            Form{
                Section{
                    HStack{
                        Spacer()
                        Button {
                            
                        } label: {
                            WebImage(url: URL(string: firebaseUserManager.user.profileImageUrl))
                                .resizable()
                                .placeholder {
                                Rectangle().foregroundColor(.gray)
                            }
                            .indicator(.activity)
                            .transition(.fade(duration: 0.5))
                            .scaledToFill()
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                            .padding(4)
                            .overlay{
                                Circle()
                                    .stroke(Color.white, lineWidth: 0.4)
                            }
                            .overlay(
                                Image(systemName: "pencil")
                                    .foregroundColor(.blue)
                                , alignment: .bottomTrailing
                            )
                        }.buttonStyle(.borderless)

                    
                        Spacer()
                    }.listRowBackground(Color.clear)
                }
//                Text("userId: \(firebaseUserManager.user.id)")
                Section {
                    HStack(spacing: 8){
                        Image(systemName: "envelope")
                        Text(firebaseUserManager.user.email)
                    }

                    
                    NavigationLink {
//                        for updet username
                        UpdateUserNameView(userName:$firebaseUserManager.user.username)
                    } label: {
                        HStack{
                            Image(systemName: "person")
                            Text(firebaseUserManager.user.username)
                        }
                    }
                    NavigationLink {
                        UpdatePhoneNumberView(phoneNumber:$firebaseUserManager.user.phoneNumber)
                    } label: {
                        HStack{
                            Image(systemName: "phone")
                            Text(firebaseUserManager.user.phoneNumber)
                        }
                    }

                } header: {
//                    Text("Account Information")
                } footer: {
//                    Text(" You can updet your account")
                }
                Section {
                    NavigationLink {
                        MyRealEstatesView()
                    } label: {
                        HStack{
                            Image(systemName: "building")
                            Text(" My Facilities")
                        }
                    }

                } footer: {
//                    Text("you can manage your proprities ")
                }
//                Section {
//                    NavigationLink {
//
//                    } label: {
//                        HStack{
//                            Image(systemName: "bookmark.fill")
//                            Text("Saved")
//                        }
//                    }
//
//            }
//                header: {
//                    Text("book markes")
//                }footer: {
//
//                    Text("visit real estate ")
//                }
//
//                Section {
//                    VStack{
//                    HStack{
//                        VStack{
//                            WebImage(url: URL(string: firebaseUserManager.user.profileImageUrl))
//                                .resizable()
//                                .placeholder {
//                                    Rectangle().foregroundColor(.gray)
//                                }
//                                .indicator(.activity)
//                                .transition(.fade(duration: 0.5))
//                                .scaledToFill()
//                                .frame(width: 50, height: 50)
//                                .clipShape(Circle())
//                                .padding(2)
//                                .overlay{
//                                    Circle()
//                                        .stroke(Color.white, lineWidth: 0.4)
//                                }
//                            Text(firebaseUserManager.user.username)
//                        }
//                        VStack{
//                            HStack{
//                                Button {
//
//                                } label: {
//                                    HStack{
//                                        Image(systemName:"envelope" )
//                                        Text("Email")
//                                    }
//                                    .foregroundColor(.white)
//                                    .frame(width: 136 , height: 34)
//                                    .background(Color.blue)
//
//                                }
//                                Button {
//
//                                } label: {
//                                    HStack{
//                                        Image(systemName:"bubble.left" )
//                                        Text("Whatsup")
//                                    }
//                                    .foregroundColor(.white)
//                                    .frame(width: 136 , height: 34)
//                                    .background(Color.indigo)
//
//                                }.buttonStyle(.borderless)
//
//                            }
//                            Button {
//
//                            } label: {
//                                HStack(spacing: 4){
//                                    Image(systemName:"phone" )
//                                    Text(firebaseUserManager.user.phoneNumber)
//                                }
//                                .foregroundColor(.white)
//                                .frame(width: 136 , height: 34)
//                                .background(Color.indigo)
//
//                            }.buttonStyle(.borderless)
//
//
//
//                        }
//                    }
//                        ForEach($firebaseUserManager.user.dayTimeAvailability, id:\.self){ $dayTime in
//                            HStack{
//                                Text(dayTime.day.title)
//                                DatePicker("", selection: $dayTime.fromTime, displayedComponents: .hourAndMinute)
//
//                                Text("-")
//
//                                DatePicker("", selection: $dayTime.toTime,displayedComponents: .hourAndMinute)
//                                    .frame(width: 100)
//                            }
//
//                        }
//                        Divider()
//                        Button {
//
//                        } label: {
//                            HStack{
//                                Spacer()
//                                Text("uploud Schedule")
//                                Spacer()
//                            }.padding(10)
//                            .foregroundColor(.white)
//                            .background(Color.blue)
//                            .background(Color.blue)
//                        }.buttonStyle(.borderless)
//
//                }
//
//                } header: {
//                    Text("Simple Viwe")
//                } footer: {
//                    Text("When people viset your propritites your contact info will be displayed is as it shown")
//                }
                Section {
                    Button {
                        isLoading.toggle()
                        firebaseUserManager.logOut { isSuccess in
                            DispatchQueue.main.asyncAfter(deadline:.now() + 1.5){
                              if isSuccess {
                                  presentationMode.wrappedValue.dismiss()
                              } else{
                                  isLoading.toggle()
                              }
                            }
                        }
                    } label: {
                        HStack{
                            Spacer()
                            Text("Log Out")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(width: 358, height: 48)
                                .background(Color("Sage"))
                                .mask(RoundedRectangle(cornerRadius: 10, style: .continuous))
                        }
                    }.buttonStyle(.borderless)

                }



            }
            .navigationTitle("Account Information")
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            presentationMode.wrappedValue.dismiss()
                            
                        } label: {
                            Text("Dismiss")
                        }

                    }
                }
        }
        .onAppear{
        firebaseUserManager.fetchUser()

       }
        .overlay {
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

        
        
    }
}
    struct ProfileView_Previews: PreviewProvider {
        static var previews: some View {
            ProfileView()
              .preferredColorScheme(.dark)
                .environmentObject(FirebaseUserManager())
        }
    }



//Text("userId: \(firebaseUserManager.user.id)")
//
//}.onAppear{
//firebaseUserManager.fetchUser()
//}
