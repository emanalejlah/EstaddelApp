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
            ForEach (0 ..< 5){ item in
                NavigationLink {
                    
                } label: {
                    HStack{
                      
                        Image("Image 1")
                            .resizable()
                            
                                .frame(width: 100 , height: 110)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                    
                        Divider()
                       
                        
                        VStack(alignment: .leading , spacing: 4){
                            HStack{
                                Text("\(Int.random(in: 1000...10000))")
                                HStack{
                                    Image(systemName:SaleCategory.rent.imageName )
                                    Text(SaleCategory.rent.title)
                                }
                                
                                .foregroundColor(.cyan)
                                
                            }
                            Text(Lorem.shortTweet)
                            //   عدد                     سطور عقار وصف المدرسه
                                .lineLimit(3)
                            //                            طريقه امتداد الكلام في الوصف
                                .fixedSize(horizontal: false, vertical: true)
                            //                                .padding(.top, 2)
                                .multilineTextAlignment(.leading)
                            HStack(spacing: 4){
                                Image(systemName: RealEstateType.school.imageName)
                                Text(RealEstateType.school.title)
                                
                            }
                            
                        
                            Divider()
                            HStack{
                                HStack(spacing: 4){
                                    Image(systemName: "bed.double")
                                    Text("3")
                                }.foregroundColor(.white)
                                    .frame(width: 50 , height: 28)
                                    .background(Color.blue)
                                    .cornerRadius(8)
                                HStack{
                                    HStack(spacing: 4){
                                        Image(systemName: "shower.fill")
                                        Text("3")
                                    }.foregroundColor(.white)
                                        .frame(width: 50 , height: 28)
                                        .background(Color.orange )
                                        .cornerRadius(8)
                                    
                                }
                                    HStack(spacing: 4){
                                        Image(systemName: "photo.on.rectangle.angled")
                                        Text("3")
                                    }.foregroundColor(.white)
                                        .frame(width: 50 , height: 28)
                                        .background(Color.purple )
                                        .cornerRadius(8)
                                
                                HStack(spacing: 4){
                                    Image(systemName: "ruler.fill")
                                    Text("3")
                                }.foregroundColor(.white)
                                    .frame(width: 50 , height: 28)
                                    .background(Color.gray )
                                    .cornerRadius(8)
                                    
                                
                            }
                            
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
        .navigationTitle("my real estste")
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
            .preferredColorScheme(.dark)
    }
}
