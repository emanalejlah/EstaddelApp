//
//  PhotoPickerView.swift
//  shooltestfinal
//
//  Created by Fatma Gazwani on 01/08/1444 AH.
//

import SwiftUI

struct TextFiledsView: View {
    @StateObject var viewModel = AddRealEstateViewModel()
    var characterLimit = 20

    var body: some View {
    
    VStack{
        
        
        //                            TextField("type info", text:$viewModel.realEstate.description, axis:.vertical)
        //                                .padding()
        //                                .frame(minHeight: 10)
        Text("School Information")
            .font(.system(size: 20, weight: .bold))
            .padding(.bottom)
            .padding(.leading)
        
        
        VStack(alignment: .leading){
            
            Text("School Name:")
            CustomInputField(imageName: "building.fill",
                             placeholderText: "Educational Facility Name",
                             text: $viewModel.realEstate.EfName)
            
            Text("City Name:")
            CustomInputField(imageName: "building.fill",
                             placeholderText: "City Name",
                             text: $viewModel.realEstate.EfCity)
            
            Text("About Educational Facility:")

            HStack(alignment: .top){
                Image(systemName:"pencil.and.outline")
                .padding(.top, 8)
                TextEditor(text: $viewModel.realEstate.description)

                    
            }
            .padding(.horizontal)
            .foregroundColor(Color("Sage"))
            .frame(width: 358, height: 72)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.gray, lineWidth: 1))
            .padding(.bottom, 8)

            
            Text("Students Count:")
            CustomInputField(imageName: "person",
                             placeholderText: "How many students in class",
                             text: $viewModel.realEstate.EfstudentsNO)
            .keyboardType(.numberPad)

            
            Text("Fees:")
            CustomInputField(imageName: "dollarsign.circle",
                             placeholderText: "Your fees",
                             text: $viewModel.realEstate.Efprice)
            .keyboardType(.numberPad)
            
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.white,lineWidth: 0.2)
            )
        }.padding(.horizontal , 16)
        Divider()
        
        VStack{
            
            CustomTitle(title: "Conacat Information")
            CustomInputField(imageName: "phone",
                             placeholderText: "05XXXXXXXX",
                             text: $viewModel.realEstate.EfPhoneNu)
            .keyboardType(.numberPad)

            
            
            
            CustomInputField(imageName: "envelope",
                             placeholderText: "Email",
                             text: $viewModel.realEstate.Efemail)

            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.white,lineWidth: 0.2)
            )
        }.padding(.horizontal , 16)
        Divider()

    }

        
    }
}

struct TextFiledsView_Previews: PreviewProvider {
    static var previews: some View {
        TextFiledsView()
    }
}

