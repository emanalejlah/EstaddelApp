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
    @Binding var isShowingAddingRealEstateView: Bool
    @State var isLoading: Bool = false
//    @State var timeConact: []
    
    
    
    var body: some View {
        ScrollView{
            
            
                      Group{
                          VStack(alignment:.center){
                              Image("A")
                                  .resizable()
                                  .frame(width: 150, height: 150)
                                  .clipShape(Circle())
                                  .overlay(Circle()
                                      .stroke(Color.gray))
                                  .padding(.bottom)
                              
                              Text(realEstate.description)
                                  .font(.system(size: 17, weight: .semibold)).foregroundColor(Color("Sage"))
                              
                              VStack{
                                  Text(realEstate.EfName)
                                      .font(.system(size: 17, weight: .semibold)).foregroundColor(Color("Mandarin"))
                                  
                              }
                              
                              
                              
                              
                              HStack{
                                  Image(systemName:"person" )
                                      .font(.system(size: 25, weight: .regular))
                                      .foregroundColor(Color("Sage"))
                                  Text("Each class has")
                                  Text(realEstate.EfstudentsNO)
                                  Text("students")

                                  Spacer()
                              }
                              
                              HStack{
                                  Image(systemName:"dollarsign.circle" )
                                      .font(.system(size: 25, weight: .regular))
                                      .foregroundColor(Color("Sage"))
                                  Text(realEstate.EfPhoneNu)
                                  
                              }
                              
                              
                              
                          }.padding(.horizontal, 4)
                          
                      }
                      
                      Group{
                          
                          VStack(){
                              Text("Conacat Information")
                                  .font(.system(size: 17, weight: .semibold))
                              Divider()
                              HStack{
                                  Image(systemName:"envelope" )
                                      .font(.system(size: 25, weight: .regular))
                                      .foregroundColor(Color("Sage"))
                                  Text(realEstate.EfName)
                              }
                              Divider()
                              HStack{
                                  Image(systemName:"phone" )
                                      .font(.system(size: 25, weight: .regular))
                                      .foregroundColor(Color("Sage"))
                                  Text(realEstate.EfPhoneNu)
                                  
                              }
                              
                          }
                      }
            Group{
                VStack{
                    Text("Photo")
                    
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
                                            //                                                        Text("\(realEstate.images.count)")
                                            Text("\(images.count)")
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
                                        Text("\(realEstate.price)")
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
                    
                }
            }

                   
            
//            Divider()
//            VStack(alignment:.leading){
//                HStack{
//                    Text("Info")
//                        .foregroundColor(.orange)
//                        .font(.title)
//                    Spacer()
//                }
//
//                Text(realEstate.description)
//                    .multilineTextAlignment(.leading)
//                    .padding(.leading, 2)
//            }.padding(.horizontal, 4)

            Divider()
            ApplianceView(realEstate: $realEstate)
            
//            Divider()
//            AmenitieView(realEstate: $realEstate)
            
      
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
                    Text(firebaseUserManager.user.username)
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
                        isLoading.toggle()
                        realEstate.ownerId = firebaseUserManager.user.id
                        firebaseRealEstateManager.addRealEstate(realEstate: realEstate, images: images) { isSuccess in
                      
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            if isSuccess {
                                self.isShowingAddingRealEstateView = false
                            }else {
                                isLoading.toggle()
                                print("DUBAG: errorb while uploding realestate")
                            }
                           
                        }
                        }
                    } label: {
                        Text("Show your deteial")
                            .foregroundColor(.white)
                            .background(Color.blue)
                    }

                }
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
           }   .isHidden(!isLoading,remove:!isLoading)
               
       }

        .navigationTitle("text")

    }

}

struct SampleRealEstate_Previews: PreviewProvider {
    static var previews: some View {
        SampleRealEstate(realEstate: .constant(realEstateSample),
                         images: .constant([UIImage(named: "Image 1")!,UIImage(named: "Image 2")!,UIImage(named: "Image 3")!]),
                         coordinateRegion:  .constant(.init(center: realEstateSample.location, span: realEstateSample.city.extraZoomLevel)),
                         isShowingAddingRealEstateView: .constant(false))
//            .preferredColorScheme(.dark)
           .environmentObject(FirebaseUserManager())
           .environmentObject(FirebaseRealEstateManager())
           
    }
}
