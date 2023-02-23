//
//  MyRealEstatesView.swift
//  shooltestfinal
//
//  Created by eman alejilah on 28/07/1444 AH.
//

import SwiftUI
import SDWebImageSwiftUI
import LoremSwiftum

struct MyRealEstatesView: View {
    @EnvironmentObject var firebaseUserManager : FirebaseUserManager
    @EnvironmentObject var firebaseRealEstateManager : FirebaseRealEstateManager
    var body: some View {
        ScrollView{
            ForEach (firebaseRealEstateManager.myRealEstates){ realEstates in
                NavigationLink {
                    
                } label: {
                    HStack{
                      
//                        WebImage(url: URL(string: realEstates.images.first ?? ""))
//                            .resizable()
//                            .placeholder {
//                            Rectangle().foregroundColor(.gray)
//                        }
//                        .indicator(.activity)
//
//
//                                .frame(width: 100 , height: 110)
//                                .clipShape(RoundedRectangle(cornerRadius: 12))
                    
                        HStack{
                           
                                WebImage(url: URL(string: realEstates.images.first ?? ""))
                                    .resizable()
                                    .placeholder {
                                        Rectangle().foregroundColor(.gray)
                                        
                                    }
                                    .indicator(.activity)
                                    .scaledToFill()
                                    .frame(width: 100 , height: 110)
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                                    .padding(.leading)
                                
                         
                            //                            Divider()
//                            BubbleView()
                            Group{
                            VStack(alignment: .leading , spacing: 8){
                                
                                Text(realEstates.EfName)
                                    .foregroundColor(Color("Sage"))
                                    .font(.callout)
                                
                                Text(realEstates.description)
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
                                        Image(systemName: realEstates.isSmart ? "desktopcomputer": "")
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 14 , height: 14)
                                        
                                    }.frame(width: 20)
                                    VStack(spacing: 2 ){
                                        Image(systemName:realEstates.hasPool ? "figure.pool.swim": "")
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 14 , height: 14)
                                        
                                    }.frame(width: 20)
                                    VStack(spacing: 2 ){
                                        Image(systemName: realEstates.hasWiFi ? "bus.fill": "")
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 14 , height: 14)
                                        
                                    }.frame(width: 20)
                                    VStack(spacing: 2 ){
                                        Image(systemName:realEstates.hasGym ? "dumbbell.fill": "")
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 14 , height: 14)
                                        
                                    }.frame(width: 20)
                                    
                                }.padding(.trailing)
                                
                                .foregroundColor(Color("Sage"))
                            }        .padding()
                                .frame(width: 250, height: 100)
                        }

                                    
                                
                            
                        
                        
                        }
                        
          
                        
                        
                    
                    
                    }
           
                    
                }.foregroundColor(Color(.label))
                
//                    .padding(.vertical , 8)
                
            }
        }
        .navigationTitle("My Facility")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct MyRealEstatesView_Previews: PreviewProvider {
    
    static var previews: some View {
     


        NavigationView{
            MyRealEstatesView()
        }
            .environmentObject(FirebaseRealEstateManager())
            .environmentObject(FirebaseRealEstateManager())
//            .preferredColorScheme(.dark)
    }
}
