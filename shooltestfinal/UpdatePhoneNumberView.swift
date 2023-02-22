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
            TextField("Enter Phone Number", text: $phoneNumber)
               
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

struct UpdatePhoneNumberView_Previews: PreviewProvider {
    static var previews: some View {
        UpdatePhoneNumberView(phoneNumber: .constant(""))
            .preferredColorScheme(.dark)
            .environmentObject(FirebaseUserManager())
    }
}
