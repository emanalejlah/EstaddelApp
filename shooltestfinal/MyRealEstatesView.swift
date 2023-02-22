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
//                            Group{
//                                VStack(alignment: .leading , spacing: 8){
//                                    //                                HStack{
//                                    //                                    Text("\(realEstate.price)")
//                                    //                                    HStack{
//                                    //                                        Image(systemName:realEstate.saleCategory.imageName)
//                                    //                                        Text(realEstate.saleCategory.title)
//                                    //                                    }
//
//                                    //                                    .foregroundColor(.cyan)
//
//                                    //                                }
//                                    Text(realEstate.EfName)
//                                        .foregroundColor(Color("Sage"))
//
//                                    Text(realEstate.description)
//                                        .foregroundColor(Color("OnyxGray"))
//                                    //   عدد                     سطور عقار وصف المدرسه
//                                        .lineLimit(3)
//                                    //                            طريقه امتداد الكلام في الوصف
//                                        .fixedSize(horizontal: false, vertical: true)
//                                    //                                .padding(.top, 2)
//                                        .multilineTextAlignment(.leading)
//
//
//
//                                    //                                Divider()
//                                    //                                HStack{
//                                    //                                    HStack(spacing: 4){
//                                    //                                        Image(systemName: "bed.double")
//                                    //                                        Text("\(realEstate.beds)")
//                                    //                                    }.foregroundColor(.white)
//                                    //                                        .frame(width: 50 , height: 28)
//                                    //                                        .background(Color.blue)
//                                    //                                        .cornerRadius(8)
//                                    //                                    HStack{
//                                    //                                        HStack(spacing: 4){
//                                    //                                            Image(systemName: "shower.fill")
//                                    //                                            Text("\(realEstate.baths)")
//                                    //                                        }.foregroundColor(.white)
//                                    //                                            .frame(width: 50 , height: 28)
//                                    //                                            .background(Color.orange )
//                                    //                                            .cornerRadius(8)
//                                    //
//                                    //                                    }
//                                    //                                        HStack(spacing: 4){
//                                    //                                            Image(systemName: "photo.on.rectangle.angled")
//                                    //                                            Text("\(realEstate.images.count)")
//                                    //                                        }.foregroundColor(.white)
//                                    //                                            .frame(width: 50 , height: 28)
//                                    //                                            .background(Color.purple )
//                                    //                                            .cornerRadius(8)
//                                    //
//                                    //                                    HStack(spacing: 4){
//                                    //                                        Image(systemName: "ruler.fill")
//                                    //                                        Text("\(realEstate.space)")
//                                    //                                    }.foregroundColor(.white)
//                                    //                                        .frame(width: 50 , height: 28)
//                                    //                                        .background(Color.gray )
//                                    //                                        .cornerRadius(8)
//                                }
//
//                                Group{
//                                    HStack(spacing: 10 ){
//
//                                        Spacer()
//                                        VStack(spacing: 2 ){
//                                            Image(systemName: realEstate.isSmart ? "desktopcomputer": "")
//                                                .resizable()
//                                                .scaledToFill()
//                                                .frame(width: 24 , height: 24)
//
//                                        }.frame(width: 44)
//                                        //                                            VStack(spacing: 2 ){
//                                        //                                                Image(systemName: realEstate.hasWiFi ? "bus.fill": "")
//                                        //                                                    .resizable()
//                                        //                                                    .scaledToFill()
//                                        //                                                    .frame(width: 24 , height: 24)
//                                        //
//                                        //                                            }.frame(width: 44)
//                                        VStack(spacing: 2 ){
//                                            Image(systemName: realEstate.hasPool ? "figure.pool.swim": "")
//                                                .resizable()
//                                                .scaledToFill()
//                                                .frame(width: 24 , height: 24)
//
//                                        }.frame(width: 44)
//                                        VStack(spacing: 2 ){
//                                            Image(systemName: realEstate.hasElevator ? "figure.roll": "")
//                                                .resizable()
//                                                .scaledToFill()
//                                                .frame(width: 24 , height: 24)
//
//                                        }.frame(width: 60)
//                                        VStack(spacing: 2 ){
//                                            Image(systemName: realEstate.hasGym ? "dumbbell.fill": "")
//                                                .resizable()
//                                                .scaledToFill()
//                                                .frame(width: 24 , height: 24)
//
//                                        }.frame(width: 44)
//
//                                    }.padding(.top)
//                                        .foregroundColor(Color("Sage"))
//                                }
//                            }
    //
    //
    //
    //                                }
                                    
                                
                            
                        
                        
                        }
                        
          
                        
                        
                        Spacer()
                    Image(systemName: "chevron.right")
                            .opacity(0.6)
                            .padding(.trailing,8)
                    
                    }
           
                    
                }.foregroundColor(Color(.label))
                    .overlay (
                        Menu {
                            ForEach(0 ..< 5){ item in
                                Button {
                                    
                                } label: {
                                       Text("option\(item)")
                                }

                            }
                            Divider()
                            Button(role: .destructive) {
                                
                            } label: {
                                Label("Delete", systemImage: "trach")
                            }

                        } label: {
                            Image(systemName: "ellipsis")
                                .foregroundColor(.blue)
                                .padding(8)
                        }
                        , alignment: .topTrailing
                    )
                Divider()
                    .padding(.vertical , 8)
                
            }
        }
        .navigationTitle("My Education Complex")
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
