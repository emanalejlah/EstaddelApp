//
//  HomeView.swift
//  shooltestfinal
//
//  Created by eman alejilah on 26/07/1444 AH.
//

import SwiftUI
import SDWebImageSwiftUI
import MapKit
import LoremSwiftum

struct MyStore {
    var location: CLLocationCoordinate2D
    var lat: Double
    var long: Double
    
}
struct HomeView: View {
    @EnvironmentObject var firebaseUserManager : FirebaseUserManager
    @EnvironmentObject var firebaseRealEstateManager  : FirebaseRealEstateManager    //    for show city
    @State var coordinateRegion : MKCoordinateRegion = .init(center: City.riyadh.coordinate, span: .init(latitudeDelta: 0.06, longitudeDelta: 0.06))
    
//        نطلع احاثيات المواقع زي المدارس
    @State var myRealEstates: [RealEstate] = [
        .init(location: .init(latitude: 24.860669, longitude: 46.721979)),
                .init(location: .init(latitude: 24.824257, longitude: 46.763395)),


    ]
    
    @State var selectedRealEstate : RealEstate?
    
    
    @State var popupBGColor = Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1))
    @StateObject var locationManager = LocationManager()
    
    @State var isShowingProfileView: Bool = false
    @State var isShowingLoginView: Bool = false
    @State var isShowingAddingRealEstateView: Bool = false
    var body: some View {
        NavigationView {
            Map(coordinateRegion: $locationManager.region,
                interactionModes: .all ,
                showsUserLocation: true ,  annotationItems: $firebaseRealEstateManager.realEstates ) { $realEstate in
//               MapMarker(coordinate: realEstate.location)
                MapAnnotation(coordinate: realEstate.location) {
                    
                    
                    NavigationLink {
                        RealEstateDetailView(realEstate: $realEstate)
                            .onDisappear{
                                withAnimation{
                                    locationManager.region.span = .init(latitudeDelta: 0.1, longitudeDelta: 0.1)
                                }
                            }
                        
                    } label: {
                        HStack{
                            if !realEstate.images.isEmpty{
                                WebImage(url: URL(string: realEstate.images.first ?? "" ))
                                    .resizable()
                                    .placeholder {
                                    Rectangle().foregroundColor(.gray)
                                }
                                .indicator(.activity)
                                    .scaledToFill()
                                    .frame(width: 100 , height: 110)
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                            } else {
                            Image(systemName: "photo")
                                  
                            }
                            Divider()
                           
                            
                            VStack(alignment: .leading , spacing: 4){
                                HStack{
                                    Text("\(realEstate.price)")
                                    HStack{
                                        Image(systemName:realEstate.saleCategory.imageName)
                                        Text(realEstate.saleCategory.title)
                                    }
                                    
                                    .foregroundColor(.cyan)
                                    
                                }
                                Text(realEstate.description)
                                //   عدد                     سطور عقار وصف المدرسه
                                    .lineLimit(3)
                                //                            طريقه امتداد الكلام في الوصف
                                    .fixedSize(horizontal: false, vertical: true)
                                //                                .padding(.top, 2)
                                    .multilineTextAlignment(.leading)
                                HStack(spacing: 4){
                                    Image(systemName:realEstate.type.imageName)
                                    Text(realEstate.type.title)
                                    
                                }
                                
                            
                                Divider()
                                HStack{
                                    HStack(spacing: 4){
                                        Image(systemName: "bed.double")
                                        Text("\(realEstate.beds)")
                                    }.foregroundColor(.white)
                                        .frame(width: 50 , height: 28)
                                        .background(Color.blue)
                                        .cornerRadius(8)
                                    HStack{
                                        HStack(spacing: 4){
                                            Image(systemName: "shower.fill")
                                            Text("\(realEstate.baths)")
                                        }.foregroundColor(.white)
                                            .frame(width: 50 , height: 28)
                                            .background(Color.orange )
                                            .cornerRadius(8)
                                        
                                    }
                                        HStack(spacing: 4){
                                            Image(systemName: "photo.on.rectangle.angled")
                                            Text("\(realEstate.images.count)")
                                        }.foregroundColor(.white)
                                            .frame(width: 50 , height: 28)
                                            .background(Color.purple )
                                            .cornerRadius(8)
                                    
                                    HStack(spacing: 4){
                                        Image(systemName: "ruler.fill")
                                        Text("\(realEstate.space)")
                                    }.foregroundColor(.white)
                                        .frame(width: 50 , height: 28)
                                        .background(Color.gray )
                                        .cornerRadius(8)
                                        
                                    
                                }
                                
                            }
                            
                            Spacer()
                        
                        
                        }
                        
                        
    //                    حجم مربع العرض والوصف
                        .frame(width:UIScreen.main.bounds.width - 50)
                        
    //                    .frame(width:340 )
                        .padding(6)
                        
                        
                        .background(popupBGColor.cornerRadius(12))
                
                        .padding(.bottom , -14)
                    }.foregroundColor(.white)
                        .overlay(
                            Button{
                                withAnimation{
                                    selectedRealEstate = nil
                                }
                            
                            } label: {
                                Image(systemName: "eye.slash")
                                    .foregroundColor(.yellow)
                                    .padding(6)
                            }
                            , alignment: .topTrailing
                        )

                        .scaleEffect(selectedRealEstate == realEstate ? 1 : 0)
                        .opacity(selectedRealEstate == realEstate ? 1 : 0)
                        .animation(.spring(), value: selectedRealEstate == realEstate)

                    
                    Button {
                        withAnimation(.spring()){
                        selectedRealEstate = realEstate
                           locationManager.region.center = realEstate.location
                       }
                    } label: {
                        HStack{
                            Image(systemName: "info.circle")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 20 , height: 20)
                            Text("\(realEstate.price)")
                            
                                .foregroundColor(.white)
                            
                            Image(systemName: realEstate.type.imageName)
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
                    }

               
                
            }
            .ignoresSafeArea()
            .overlay(
                HStack{
                    Button {
        //                اذا سجل الدخول تكون المعلومات موجودة اذا ماسسجل الدخول تكون فاضيه
                        if firebaseUserManager.user.id == "" {
                          isShowingLoginView.toggle()
                        }else{
                            isShowingProfileView.toggle()
                        }


                    } label: {
                        WebImage(url: URL(string: firebaseUserManager.user.profileImageUrl))
                            .resizable()
                            .placeholder {
                            Rectangle().foregroundColor(.gray)
                        }
                        .indicator(.activity)
                        .transition(.fade(duration: 0.5))
                        .scaledToFill()
                        .frame(width: 48, height: 48)
                        .clipShape(Circle())
                        .padding(4)
                        .overlay{
                            Circle()
                                .stroke(Color.white, lineWidth: 0.4)
                        }
                        .padding()
                    }
                    .padding(.bottom ,8)
                    Text(firebaseUserManager.user.username)
                    Spacer()
                    
                    Button {
                        isShowingAddingRealEstateView.toggle()
                    } label: {
                        Text("add real Estate")
                    }.padding(.leading , 155)

                    

                    Spacer()
                }.frame(height: 60)
                    .background(Material.ultraThinMaterial)
                , alignment: .top
            )
            .overlay(
                
                VStack(spacing : 14){
                    Button {
                        withAnimation{
                            if let center = locationManager.userLocation?.coordinate {
                                locationManager.region.center = center
                            }  
                        }
                       
                    } label: {
                        Image(systemName: "scope")
                            .frame(width: 30, height: 30)
                    }
                    
                    Divider()
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "line.3.horizontal.decrease")
                        
                            .frame(width: 18, height: 18)
                    }

                }
                    .frame(width: 46, height: 140)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .background(Material.ultraThinMaterial)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.white.opacity(0.6), lineWidth: 0.6)
                    )
                    .padding()
                , alignment: .bottomTrailing
                
                
                
            )
        }
        .fullScreenCover(isPresented: $isShowingAddingRealEstateView) {
            AddRealEstateView(isShowingAddingRealEstateView: $isShowingAddingRealEstateView)
        }
                .fullScreenCover(isPresented: $isShowingLoginView,onDismiss: firebaseUserManager.fetchUser) {
                    Login()
                }
        
        .fullScreenCover(isPresented: $isShowingProfileView) {
            ProfileView()
        }
            ////            اخذ الاحداثيات عشان نرجع نعرضها
//        VStack{
//            //            to fitch all info of users
//            Text("User id: \(firebaseUserManager.user.id)")
//            Button {
////                اذا سجل الدخول تكون المعلومات موجودة اذا ماسسجل الدخول تكون فاضيه
//                if firebaseUserManager.user.id == "" {
//                  isShowingLoginView.toggle()
//                }else{
//                    isShowingProfileView.toggle()
//                }
//
//
//            } label: {
//                WebImage(url: URL(string: firebaseUserManager.user.profileImageUrl))
//                    .resizable()
//                    .placeholder {
//                    Rectangle().foregroundColor(.gray)
//                }
//                .indicator(.activity)
//                .transition(.fade(duration: 0.5))
//                .scaledToFill()
//                .frame(width: 100, height: 100)
//                .clipShape(Circle())
//                .padding(4)
//                .overlay{
//                    Circle()
//                        .stroke(Color.white, lineWidth: 0.4)
//                }
//            }
//
//            Text(firebaseUserManager.user.username)
//            Text(firebaseUserManager.user.email)
//
//        }.onAppear{
//            firebaseUserManager.fetchUser()
//        }
////        .fullScreenCover(isPresented:  $isShowingLoginView) {
////            Login()
////        }
//        .fullScreenCover(isPresented: $isShowingLoginView,onDismiss: firebaseUserManager.fetchUser) {
//            Login()
//        }
//        .fullScreenCover(isPresented: $isShowingProfileView) {
//            ProfileView()
//        }
        }
    }

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .preferredColorScheme(.dark)
            .environmentObject(FirebaseUserManager())
            .environmentObject(FirebaseRealEstateManager())
    }
}
struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))

        return path
    }
}




