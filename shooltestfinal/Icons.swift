//
//  Icons.swift
//  shooltestfinal
//
//  Created by Fatma Gazwani on 01/08/1444 AH.
//

import SwiftUI

struct Icons: View {
    let iconName: Bool

    var body: some View {
        VStack(spacing: 2 ){
            Image(systemName: iconName ? "desktopcomputer": "")
                .resizable()
                .scaledToFill()
                .frame(width: 24 , height: 24)

        }.frame(width: 44)    }
}

struct Icons_Previews: PreviewProvider {
    static var previews: some View {
        Icons(iconName: realEstate.isSmart )
    }
}
