//
//  BubbleView.swift
//  shooltestfinal
//
//  Created by Fatma Gazwani on 01/08/1444 AH.
//

import SwiftUI

struct BubbleView: View {
    @StateObject var viewModel = AddRealEstateViewModel()
    
    var body: some View {
        
        

            
            VStack(alignment: .leading , spacing: 8){
                
                Text(viewModel.realEstate.EfName)
                    .foregroundColor(Color("Sage"))
                    .font(.callout)
                
                Text(viewModel.realEstate.description)
                    .foregroundColor(Color("OnyxGray"))
                    .font(.footnote)
                
                //   عدد                     سطور عقار وصف المدرسه
                    .lineLimit(2)
                //                            طريقه امتداد الكلام في الوصف
                    .fixedSize(horizontal: false, vertical: true)
                //                                .padding(.top, 2)
                    .multilineTextAlignment(.leading)
                
                
                HStack(spacing: 10 ){
                    
                    Spacer()
                    VStack(spacing: 2 ){
                        Image(systemName: viewModel.realEstate.isSmart ? "desktopcomputer": "")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 14 , height: 14)
                        
                    }.frame(width: 20)
                    VStack(spacing: 2 ){
                        Image(systemName: viewModel.realEstate.hasPool ? "figure.pool.swim": "")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 14 , height: 14)
                        
                    }.frame(width: 20)
                    VStack(spacing: 2 ){
                        Image(systemName: viewModel.realEstate.hasWiFi ? "bus.fill": "")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 14 , height: 14)
                        
                    }.frame(width: 20)
                    VStack(spacing: 2 ){
                        Image(systemName:viewModel.realEstate.hasGym ? "dumbbell.fill": "")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 14 , height: 14)
                        
                    }.frame(width: 20)
                    
                }
                
                .foregroundColor(Color("Sage"))
            }        .padding()
            .frame(width: 250, height: 100)
            
        
        
        
        
        
        
        
        
    }    }

struct BubbleView_Previews: PreviewProvider {
    static var previews: some View {
        BubbleView()
    }
}
