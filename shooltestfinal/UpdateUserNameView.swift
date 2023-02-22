//
//  UpdateUserNameView.swift
//  shooltestfinal
//
//  Created by eman alejilah on 26/07/1444 AH.
//

//

import SwiftUI

struct UpdateUserNameView: View {
    @EnvironmentObject var firebaseUserManager : FirebaseUserManager
    @Binding var userName: String
    @State var isLoading: Bool = false
//    for back step for logout
    @Environment(\.presentationMode) private var presentationMode
    
    var body: some View {
        VStack{
            TextField("Enter username", text: $userName)
            
               
            Button {
                isLoading.toggle()
                firebaseUserManager.updateUserName(username: userName) { isSuccess in
                    if isSuccess {
                        isLoading.toggle()
                        presentationMode.wrappedValue.dismiss()
                    }else{
                        isLoading.toggle()
                    }
                }
            } label: {
                Text("Save change")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(width: 358, height: 48)
                    .background(Color("Sage"))
                    .mask(RoundedRectangle(cornerRadius: 10, style: .continuous))
            }

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
            }.isHidden(!isLoading,remove:!isLoading)

                
        }
    }
}

struct UpdateUserNameView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateUserNameView(userName: .constant(""))
            .preferredColorScheme(.dark)
            .environmentObject(FirebaseUserManager())
    }
}

