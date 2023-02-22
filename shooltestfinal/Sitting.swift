//
//  Sitting.swift
//  MyEstadel
//
//  Created by Arwamohammed07 on 13/07/1444 AH.
//

import SwiftUI

struct Sitting: View {
    @State private var isFullScreen = false
    @State private var alertIsPresented = false
    @State private var alertIsPresented2 = false
    @Environment(\.presentationMode) private var presentationMode
    var body: some View {
        NavigationView{
            List{
                Section{
                    // MARK: - Privacy
                    NavigationLink (destination: Privacy(), label: {
                      
                            SittingCell(title: "Privacy and Security", imgName: "shield.righthalf.filled", clr: Color("Sage") , clor: .black)
                        
                       
                    })
                    // MARK: - Contact
                    NavigationLink (destination: Contactus(), label: {
                        SittingCell(title: "Contact us", imgName: "envelope", clr: Color("Sage") , clor: .black)
                    })
                    
//                    // MARK: - Log Out
//                    Button(action: {
//                        // Showing Alert
//                        self.alertIsPresented2.toggle()
//                    } , label: {
//                        SittingCell(title: "Log out", imgName: "arrow.left.circle", clr: Color("Green") , clor: .black)
//                    })
//
//                    .alert(isPresented: $alertIsPresented2, content: {
//                        
//                        Alert(title: Text("Are you sure you want to logout?"), primaryButton: .default(Text("Log Out")
//                            .foregroundColor(Color.red)       , action: {
//                            print("Start purchase")
//                        }), secondaryButton: .cancel(
//                            Text("Cancel")
//                                .foregroundColor(.red)
//                       ))
//                    })
//                    
//                    
//                    // MARK: - Delete Account
//                    Button(action: {
//                        // Showing Alert
//                        self.alertIsPresented.toggle()
//                    } , label: {
//                        SittingCell(title: "Delete account", imgName: "minus.circle", clr: Color("Green") , clor: .red)
//                    })
//
//                    .alert(isPresented: $alertIsPresented, content: {
//                        
//                        Alert(title: Text("Are you sure you want to delete your account?"), primaryButton: .default(Text("Delete") , action: {
//                            print("Start purchase")
//                        }), secondaryButton: .cancel(Text("Cancel")))
//                    })
//                    
                    
                    // MARK: - Header

            }
            .navigationTitle("Setting")

        }    .toolbar{
            ToolbarItem(placement: .navigationBarLeading){
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("DISSMIS")
                }
                
            }
        }
    }
    }
}

struct Sitting_Previews: PreviewProvider {
    static var previews: some View {
        Sitting()
    }
}
