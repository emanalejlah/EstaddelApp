//
//  New.swift
//  MyEstadel
//
//  Created by Arwamohammed07 on 15/07/1444 AH.
//

import SwiftUI

struct Privacy: View {
    var body: some View {
        NavigationView{
            ScrollView{
                Text("""
                     [Terms of Service](https://privacyterms.io/view/W1cYQuwt-DYAUzz1B-UFfFwO/)
                     """)
              
                
            }.navigationTitle(" Privacy Policy")
//                .toolbar{
//                    ToolbarItemGroup(placement: .navigationBarLeading) {
//                        Button("Back") {
//
//                        }
//                    }
//                }
        }
    }
}

struct Privacy_Previews: PreviewProvider {
    static var previews: some View {
        Privacy()
    }
}
