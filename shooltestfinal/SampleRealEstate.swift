//
//  SampleRealEstate.swift
//  shooltestfinal
//
//  Created by eman alejilah on 27/07/1444 AH.
//

import SwiftUI
import AVKit
import LoremSwiftum
import MapKit
import SDWebImageSwiftUI

struct SampleRealEstate: View {
    @EnvironmentObject var firebaseUserManager : FirebaseUserManager
    @EnvironmentObject var firebaseRealEstateManager : FirebaseRealEstateManager
    @Binding var realEstate: RealEstate
    @Binding var images:[UIImage]
//    @Binding var videoUrl: URL?
    @State var selectedMediaType: MediaType = .photos
    @Binding var coordinateRegion: MKCoordinateRegion
//    @State var timeConact: []
    
    
    
    var body: some View {
        ScrollView{
            Picker(selection: $selectedMediaType) {
                ForEach(MediaType.allCases, id:\.self){ mediaType in
                    Text(mediaType.title)
                }
                
            } label: {
            }.labelsHidden()
            
            .pickerStyle(.segmented)
       
            
            switch selectedMediaType {
            case .photos:
                                if !images.isEmpty{
                                    TabView{
                                        ForEach(images, id:\.self){ uiImage in
                                            Image(uiImage: uiImage)
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: UIScreen.main.bounds.width - 20 , height: 340)
                                                .clipShape(RoundedRectangle(cornerRadius: 12))
                                                .offset(y: -20)
                
                                        }
                                    }.tabViewStyle(.page(indexDisplayMode: .always))
                                        .indexViewStyle(.page(backgroundDisplayMode: .always))
                                        .frame(height:400)
                                        .overlay(
                                            VStack{
                                                HStack{
                                                    HStack{
                                                        Image(systemName: "photo")
                                                        Text("\(realEstate.images.count)")
                                                    }
                                                    .padding(8)
                                                        .background(Material.ultraThin)
                                                        .clipShape(RoundedRectangle(cornerRadius: 12))
                                                    Spacer()
                                                    Image(systemName: "bookmark")
                                                        .padding(8)
                                                            .background(Material.ultraThin)
                                                            .clipShape(Circle())
                                                }
                                                Spacer()
                                                HStack{
                                                    HStack{
                                                        Image(systemName: realEstate.saleCategory.imageName)
                                                        Text("\(realEstate.saleCategory.title)")
                                                    }
                                                    .padding(8)
                                                        .background(Material.ultraThin)
                                                        .clipShape(RoundedRectangle(cornerRadius: 12))
                                                    Spacer()
                                                    Text("\(realEstate.price , specifier: "%0.0f")")
                                                        .padding(8)
                                                            .background(Material.ultraThin)
                                                            .clipShape(Circle())
                                                }
                                            }.padding()
                                                .padding(.bottom, 36)
                                        )
                                }else {
                                    Image(systemName: "photo")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 100 , height: 100)
                                        .opacity(0.4)
                                        .padding(.vertical)
                                }
                
            case .video:
                Text ("nn")
//                VideoPlayer(player:AVPlayer(url: URL(string: realEstate.videoUrlString)!))
//                    .frame(width:UIScreen.main.bounds.width ,
//                           height: 340)
                   
            }
            Divider()
            VStack(alignment:.leading){
                HStack{
                    Text("Info")
                        .foregroundColor(.orange)
                        .font(.title)
                    Spacer()
                }

                Text(realEstate.description)
                    .multilineTextAlignment(.leading)
                    .padding(.leading, 2)
            }.padding(.horizontal, 4)

            Divider()
            ApplianceView(realEstate: $realEstate)
            
            Divider()
            AmenitieView(realEstate: $realEstate)
            
      
            Map(coordinateRegion: $coordinateRegion, annotationItems: [realEstate]){ realEstate in
                MapAnnotation(coordinate: realEstate.location) {
                    HStack{
                        Image(systemName: "info.circle")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 20 , height: 20)
                        Text("1000")
                        
                            .foregroundColor(.white)
                        
                        Image(systemName: "house")
                            .foregroundColor(.white)
                        
                    }
                        .padding(.bottom,12)
                        .padding()
                        .background(
                            VStack(spacing: 0){
                                Spacer()
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color.green)
                                Triangle()
                                    .fill(Color.green)
                                    .frame(width: 20 , height: 20)
                                    .rotationEffect(.init(degrees: 180))
                            }
                        )
                    
                }
                
            } .frame(width:UIScreen.main.bounds.width - 50,
                     height: 240)
            .cornerRadius(12)
            .onAppear{
                coordinateRegion.center = realEstate.location
                coordinateRegion.span = realEstate.city.extraZoomLevel
            }
            Group{
            HStack{
                VStack{
//          Image("people-1")
                    WebImage(url: URL(string: firebaseUserManager.user.profileImageUrl))
                        .resizable()
                        .scaledToFill()
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                        .padding(2)
                        .overlay{
                            Circle()
                                .stroke(Color.white, lineWidth: 0.4)
                        }
                    Text(Lorem.firstName)
                }
              
                    VStack{
                        HStack{
                            Button {
                                
                            } label: {
                                HStack{
                                    Image(systemName:"envelope" )
                                    Text(firebaseUserManager.user.email)
                                }
                                .foregroundColor(.white)
                                .frame(width: 136 , height: 34)
                                .background(Color.blue)
                                
                            }
                            Button {
                                
                            } label: {
                                HStack{
                                    Image(systemName:"bubble.left" )
                                    Text("Whatsup")
                                }
                                .foregroundColor(.white)
                                .frame(width: 136 , height: 34)
                                .background(Color.indigo)
                                
                            }.buttonStyle(.borderless)

                        }
                        Button {
                            
                        } label: {
                            HStack(spacing: 4){
                                Image(systemName:"phone" )
                                Text(firebaseUserManager.user.phoneNumber)
                            }
                            .foregroundColor(.white)
                            .frame(width: 136 , height: 34)
                            .background(Color.indigo)
                            
                        }.buttonStyle(.borderless)

                        
                        
                    }
                    
                }
                Group{
                    Button {
                        realEstate.ownerId = firebaseUserManager.user.id
                        firebaseRealEstateManager.addRealEstate(realEstate: realEstate, images: images) { isSuccess in
                           
                        }
                       
                    } label: {
                        Text("Show your deteial")
                            .foregroundColor(.white)
                            .background(Color.blue)
                    }

                }
                }
         

            
        

        }
        
       

        .navigationTitle("text")

    }

}

struct SampleRealEstate_Previews: PreviewProvider {
    static var previews: some View {
        SampleRealEstate(realEstate: .constant(realEstateSample),
                         images: .constant([UIImage(named: "Image 1")!,UIImage(named: "Image 2")!,UIImage(named: "Image 3")!]),
                         coordinateRegion:  .constant(.init(center: realEstateSample.location, span: realEstateSample.city.extraZoomLevel)))
            .preferredColorScheme(.dark)
           .environmentObject(FirebaseUserManager())
           .environmentObject(FirebaseRealEstateManager())
           
    }
}
