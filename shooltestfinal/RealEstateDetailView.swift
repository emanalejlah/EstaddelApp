//
//  RealEstateDetailView.swift
//  shooltestfinal
//
//  Created by eman alejilah on 26/07/1444 AH.
//

import SwiftUI
import LoremSwiftum
import MapKit
import AVKit
import SDWebImageSwiftUI

enum MediaType :String, CaseIterable{
    case photos
    case video
    
    var title: String {
        switch self{
        case .photos:
            return "photos"
        case .video:
            return "video"
        }
    }
}


struct RealEstateDetailView: View {
    
    @EnvironmentObject var firebaseUserManager : FirebaseUserManager
    @EnvironmentObject var firebaseRealEstateManager  : FirebaseRealEstateManager
    @Binding var realEstate: RealEstate
    @State var selectedMediaType: MediaType = .photos
    @State var coordinateRegion: MKCoordinateRegion = .init()
//    @State var timeConact: []
    @State var ownerUser = User()
    
    
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
                    


                    
                    VStack{
                        Text(realEstate.EfName)
                            .font(.system(size: 17, weight: .semibold)).foregroundColor(Color("Sage"))
                        Text(realEstate.EfCity)
                            .font(.system(size: 17, weight: .semibold)).foregroundColor(Color("Mandarin"))
                        
                        Text(realEstate.description)
                        .font(.system(size: 17, weight: .regular)).foregroundColor(Color("OnyxGray"))
                        .padding(.bottom)
                    }
                    
                    
                    
                    
                    HStack{
                        Image(systemName:"person" )
                            .font(.system(size: 25, weight: .regular))
                            .foregroundColor(Color("Sage"))
                        Text("Each class has")
                        Text(realEstate.EfstudentsNO)
                        Text("students")

                        Spacer()
                    }                            .padding(.bottom)

                    
                    HStack{
                        Image(systemName:"dollarsign.circle" )
                            .font(.system(size: 25, weight: .regular))
                            .foregroundColor(Color("Sage"))
                        Text(realEstate.Efprice)

                        Spacer()

                        
                    }                            .padding(.bottom)

                    
                    
                    
                }.padding(.horizontal, 16)
                
            }
            
            Group{
                
                VStack(){
                    CustomTitle(title: "Conacat Information")
//                    Text("Conacat Information")
//                        .font(.system(size: 17, weight: .semibold))
                    HStack{
                        Image(systemName:"envelope" )
                            .font(.system(size: 25, weight: .regular))
                            .foregroundColor(Color("Sage"))
                        Text(realEstate.Efemail)
                        Spacer()
                    }
                    Divider()
                    HStack{
                        Image(systemName:"phone" )
                            .font(.system(size: 25, weight: .regular))
                            .foregroundColor(Color("Sage"))
                        Text(realEstate.EfPhoneNu)
                        Spacer()

                    }
                    
                }.padding(.horizontal, 16)
            }
          

//            Picker(selection: $selectedMediaType) {
//                ForEach(MediaType.allCases, id:\.self){ mediaType in
//                    Text(mediaType.title)
//                }
//
//            } label: {
//            }.labelsHidden()
//
//            .pickerStyle(.segmented)
       
          
                VStack {
                    Text("photo")
                    if !realEstate.images.isEmpty {
                        TabView{
                        ForEach(realEstate.images, id: \.self){ imageUrlString in
                           
                            if let url = URL (string: imageUrlString){
                                WebImage(url: url)
                                    .resizable()
                                    .placeholder {
                                    Rectangle().foregroundColor(.gray)
                                }
                                .indicator(.activity)
                                .transition(.fade(duration: 0.5))
                                .scaledToFill()
                                
                                    .frame(width:UIScreen.main.bounds.width - 20 ,
                                           height: 340)
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                                    .offset(y: 20)
                            }else {
                                Image(systemName: "photo")
                                      .resizable()
                                      .scaledToFit()
                                      .frame(width: 100,height: 100)
                                      .opacity(0.4)
                                      .padding(.vertical , 18)
                            }
                            
                                
                            
                        }
                    }.tabViewStyle(.page(indexDisplayMode: .always))
                        .indexViewStyle(.page(backgroundDisplayMode:.always))
                    .frame(height: 400 )
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
                                Text("\(realEstate.price )")
                                    .padding(8)
                                        .background(Material.ultraThin)
                                        .clipShape(Circle())
                            }
                        }.padding()
                            .padding(.bottom, 36)
                    )
                    } else {
                      Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100,height: 100)
                            .opacity(0.4)
                            .padding(.vertical , 18)
                    }
                }
          
           
            

            
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
            HStack{
                VStack{
                    WebImage(url: URL(string: firebaseUserManager.user.profileImageUrl))
                        .resizable()
                        .placeholder {
                        Rectangle().foregroundColor(.gray)
                    }
                    .indicator(.activity)
                    .transition(.fade(duration: 0.5))
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
//                                Text(ownerUser.email)
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
//                            Text(ownerUser.phoneNumber)
                            Text(firebaseUserManager.user.email)
                        }
                        .foregroundColor(.white)
                        .frame(width: 136 , height: 34)
                        .background(Color.indigo)
                        
                    }.buttonStyle(.borderless)

                    
                    
                }
            }
            
               
        }
        .onAppear{
            coordinateRegion.center = realEstate.location
            coordinateRegion.span = realEstate.city.extraZoomLevel
//            firebaseRealEstateManager.fetchOwnarDetial(userId: realEstate.ownerId) {
//                ownerUser in
//                self.ownerUser = ownerUser
//                print("******/n /n /n Dubagg: user owanr is \(ownerUser.id)")
//            }
        }
//        .onAppear{
//            firebaseRealEstateManager.f
//
//           }
       

        .navigationTitle("text")

    }

}

struct AmenitieView:View {
    @Binding var realEstate: RealEstate
    var body: some View{
        VStack(alignment:.center){
            HStack{
                Text("Amenities")
                    .foregroundColor(.orange)
                    .font(.title)
                Spacer()
            }
            
            HStack(spacing: 10 ){
                VStack(spacing: 2 ){
                    Image(systemName: "entry.lever.keypad.fill")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 30 , height: 30)
                    Text("smart")
                        .font(.system(size: 14, weight: .semibold))
                        .padding(.top , 2)
                    Image(systemName: realEstate.isSmart ? "checkmark.square.fill" : "xmark.square.fill")
                        .foregroundColor(realEstate.isSmart ? .green: .red)
                        .padding(.top , 4)
                }.frame(width: 60)
                Divider()
                
                VStack(spacing: 2 ){
                    Image(systemName: "wifi")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 30 , height: 30)
                    Text("wifi")
                        .font(.system(size: 14, weight: .semibold))
                        .padding(.top , 2)
                    Image(systemName: realEstate.hasWiFi ? "checkmark.square.fill" : "xmark.square.fill")
                        .foregroundColor(realEstate.hasWiFi ? .green: .red)
                        .padding(.top , 4)
                }.frame(width: 60)
                Divider()
                VStack(spacing: 2 ){
                    Image(systemName: "figure.pool.swim")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 30 , height: 30)
                    Text("wifi")
                        .font(.system(size: 14, weight: .semibold))
                        .padding(.top , 2)
                    Image(systemName: realEstate.hasPool ? "checkmark.square.fill" : "xmark.square.fill")
                        .foregroundColor(realEstate.hasPool ? .green: .red)
                        .padding(.top , 4)
                }.frame(width: 60)
                
                Divider()
                VStack(spacing: 2 ){
                    Image(systemName: "figure.walk.arrival")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 30 , height: 30)
                    Text("wifi")
                        .font(.system(size: 14, weight: .semibold))
                        .padding(.top , 2)
                    Image(systemName: realEstate.hasElevator ? "checkmark.square.fill" : "xmark.square.fill")
                        .foregroundColor(realEstate.hasElevator ? .green: .red)
                        .padding(.top , 4)
                }.frame(width: 60)
            }
            HStack{
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.gray.opacity(0.2))
                    .frame(maxWidth:.infinity)
                    .frame(height: 1)
                
                
            }
        }.padding(.horizontal , 4)
        
    }
}

struct ApplianceView: View {
    @Binding var realEstate: RealEstate
    var body: some View{
     
        
        VStack(alignment:.center){
            HStack{
                Text("Appliance")
                    .foregroundColor(.orange)
                    .font(.title)
                Spacer()
            }
            HStack(spacing: 12){
                VStack{
                    Image(systemName: "bed.double.fill")
                    HStack{
                        Text( "Beds\(realEstate.beds)")
                            .minimumScaleFactor(0.5)
                    }
                } .frame(width: 90 , height: 48)
                    .background(Color.blue)
                    .cornerRadius(8)
                VStack{
                    Image(systemName: "shower.fill")
                    HStack{
                        Text( "showe\(realEstate.baths)")
                            .minimumScaleFactor(0.5)
                    }
                } .frame(width: 90 , height: 48)
                    .background(Color.orange)
                    .cornerRadius(8)
                VStack{
                    Image(systemName: "sofa.fill")
                    HStack{
                        Text( "sofa\(realEstate.livingRooms)")
                            .minimumScaleFactor(0.5)
                    }
                } .frame(width: 90 , height: 48)
                    .background(Color.purple)
                    .cornerRadius(8)
                VStack{
                    Image(systemName: "ruler.fill")
                    HStack{
                        Text( "Beds\(realEstate.baths)")
                            .minimumScaleFactor(0.5)
                    }
                } .frame(width: 90 , height: 48)
                    .background(Color.gray)
                    .cornerRadius(8)
            }
       
        }.padding(.horizontal, 4)
    }
}

struct RealEstateDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RealEstateDetailView(realEstate: .constant(realEstateSample))
                            
//            .preferredColorScheme(.dark)
              .environmentObject(FirebaseUserManager())
              .environmentObject(FirebaseRealEstateManager())

    }
}


                                            
let realEstateSample: RealEstate = .init(images: ["Image 1", "Image 2", "Image 3", "Image 4", "Image 5"],
                                            description : Lorem.paragraph,
                                         EfName : Lorem.title,
                                         Efemail : Lorem.title, EfPhoneNu : Lorem.word, EfstudentsNO : Lorem.title,
                                         Efprice : Lorem.word,
                                           beds: Int.random(in: 1...4),
                                            baths: Int.random(in: 1...4),
                                            livingRooms: Int.random (in: 1...4),
                                            space:Int.random (in: 100...200),
                                            ovens:Int.random (in: 1...4),
                                            fridges:Int.random (in: 1...4),
                                            microwaves:Int.random (in: 1...4),
                                            airConditions:Int.random (in: 1...4),
                                            isSmart:false , hasWiFi: true , hasPool: false,
                                            hasElevator:true, hasGym:false,
                                            age:Int.random (in: 1...4),
                                            location: City.riyadh.coordinate,
                                         saleCategory:.rent, city:.riyadh, type: .apartment,
                                            offer: .monthly, isAvailable: true,
                                          price: Int.random (in: 1000...10000),
                                         videoUrlString:"https://bit.ly/swswift")
                                            
                                            
      
//var EfName: String = ""
//var Efemail: String = ""
//var EfPhoneNu: String = ""
//var EfCity: String = ""
//var EfstudentsNO: String = ""
//var Efprice: String = ""
