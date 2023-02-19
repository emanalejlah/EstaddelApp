//
//  UpdatePhoneNumberView.swift
//  shooltestfinal
//
//  Created by eman alejilah on 26/07/1444 AH.
//

import SwiftUI

struct UpdatePhoneNumberView: View {
    @EnvironmentObject var firebaseUserManager : FirebaseUserManager
    @Binding var phoneNumber: String
    @State var isLoading: Bool = false
//    for back step for logout
    @Environment(\.presentationMode) private var presentationMode
    var body: some View {
        VStack{
            TextField("Enter username", text: $phoneNumber)
               
            Button {
                isLoading.toggle()
                firebaseUserManager.updatePhoneNumber(phoneNumber: phoneNumber) { isSuccess in
                    if isSuccess {
                        isLoading.toggle()
                        presentationMode.wrappedValue.dismiss()
                    }else{
                        isLoading.toggle()
                    }
                }
            } label: {
                Text("Save change")
                    .padding()
                    .foregroundColor(.white)
                    .frame(width: 280 , height: 40)
                    .background(Color.blue)
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

struct UpdatePhoneNumberView_Previews: PreviewProvider {
    static var previews: some View {
        UpdatePhoneNumberView(phoneNumber: .constant(""))
            .preferredColorScheme(.dark)
            .environmentObject(FirebaseUserManager())
    }
}
