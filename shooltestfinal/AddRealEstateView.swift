//
//  AddRealEstateView.swift
//  shooltestfinal
//
//  Created by eman alejilah on 27/07/1444 AH.
//

import SwiftUI
import PhotosUI
import LoremSwiftum
import MapKit
import AVKit
import SDWebImageSwiftUI

class AddRealEstateViewModel: ObservableObject {
    @EnvironmentObject var firebaseUserManager : FirebaseUserManager

    @Published var realEstate = RealEstate()
    @Published var images: [UIImage] = []
   @Published var selection: [PhotosPickerItem] = []
    @Published var isShowingVideoPickerView: Bool = false
//   @Published var videoUrl: URL?
    @Published var refreshMapViewId = UUID()
    @Published var coordinateRegion: MKCoordinateRegion = .init(center: .init(latitude: 0.0, longitude: 0.0), span: .init(latitudeDelta: 0.0, longitudeDelta: 0.0))
    @State var profileImage: UIImage?
    
//    @Published var refreshMapViewId = UUID()
    
//    @Published var coordinateRegion: MKCoordinateRegion = .init(center: .init(latitude: 0.0,longitude: 0.0),
//                                                                span: .init(latitudeDelta: 0.0, longitudeDelta: 0.0))
//    @Published var coordinateRegion: MKCoordinateRegion = .init(center: .init(latitude: 0.0 , longitude: 0.0),
//                                                                span: .init(latitudeDelta: 0.0, longitudeDelta: 0.0))
    
}

struct AddRealEstateView: View {
    
    @StateObject var viewModel = AddRealEstateViewModel()
    @EnvironmentObject var firebaseUserManager : FirebaseUserManager
    @Binding var isShowingAddingRealEstateView: Bool
    @State private var showImagePickerOptions: Bool = false
    @State private var showImagePicker: Bool = false
    @State private var sourceType = UIImagePickerController.SourceType.photoLibrary
    @State private var photo:UIImage?
    @Environment(\.presentationMode) private var presentationMode
    var characterLimit = 20

    var body: some View {
        NavigationView{
            ScrollView{
                VStack{
                    Image("A")
                        .resizable()
                        .frame(width: 150, height: 150)
                        .clipShape(Circle())
                        .overlay(Circle()
                            .stroke(Color.gray))
                        .padding(.bottom)
//                    Text("ABC international school")
//                        .font(.system(size: 17, weight: .semibold)).foregroundColor(Color("Sage"))
//
//                    Text("Riyadh")
//                        .font(.system(size: 17, weight: .regular)).foregroundColor(Color("Mandarin"))
//                    TextFiledsView()
                    Group{

                        VStack{
                    
                    
                                                                    Text("School Information")
                        .font(.system(size: 20, weight: .bold))
                        .padding(.bottom)
                        .padding(.leading)
                            Group{
                                
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
                            }
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
//                    }
                }
                Group{
                    VStack{
                        HStack{
                            CustomTitle(title: "Photos:")
                            Spacer()
                            
                        }
                        
                        LazyVGrid(columns: [GridItem.init(.adaptive(minimum: 140))]){
                            ForEach(viewModel.images, id:\.self){ image in
                                VStack{
                                    Image(uiImage: image)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 180 , height:
                                                180)
                                        .clipShape(RoundedRectangle(cornerRadius: 12 ))
                                    Button {
                                        withAnimation(.spring()){
                                            if let deletedPhoto = viewModel.images.firstIndex(of: image){
                                                viewModel.images.remove(at: deletedPhoto)
                                            }
                                        }
                                    } label: {
                                        Label("Delet", systemImage: "trash")
                                            .foregroundColor(.red)
                                            .frame(width: 160 , height: 40)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 12)
                                                    .stroke(Color.red, lineWidth: 0.4)
                                            )
                                    }
                                    
                                }.padding(.vertical, 8)
                            }
                            
                            PhotosPicker(selection: $viewModel.selection, maxSelectionCount: 6, matching: .images, preferredItemEncoding: .automatic){
                                VStack{
                                    VStack{
                                        Image(systemName: viewModel.images.count == 0 ? "icloud.and.arrow.up" : "plus")
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 40 , height: 40)
                                        
                                        Label(viewModel.images.count == 0 ? "uploud" : "Add more" , systemImage: "photo.stack")
                                        
                                        
                                        
                                        //                            Label("uploud photos", systemImage: "photo.stack")
                                    }
                                    .frame(width: 180 , height: 180)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 12)
                                            .strokeBorder(style: StrokeStyle(lineWidth: 2 , dash: [10]) )
                                    )
                                    RoundedRectangle(cornerRadius: 0)
                                        .fill(Color.clear)
                                        .frame(width: 160 , height: 40)
                                }
                                
                                
                            }.onChange(of: viewModel.selection) { _ in
                                for item in viewModel.selection{
                                    Task{
                                        if let data = try? await item.loadTransferable(type: Data.self){
                                            //                                    profileImage = UIImage(data: data)
                                            guard let uiImage = UIImage(data: data) else {return}
                                            viewModel.images.append(uiImage)
                                        }
                                    }
                                }
                            }
                            //
                            //
                            
                        }
                        
                        
                    }
                   
                    
                }.padding(.horizontal, 16)
                
              
                
                
   
//                VStack(alignment: .center) {
//                    HStack {
//                        Text("Appliances")
//                            .foregroundColor(.orange)
//                            .font(.title)
//                        Spacer()
//                    }
//
//                    HStack(spacing: 12){
//
//                        Menu {
//                            ForEach(0...10, id: \.self) { beds in
//                                Button {
//                                    viewModel.realEstate.beds = beds
//                                } label:  {
//                                    switch beds {
//                                    case 0,1:
//                                        Text("\(beds) Bed")
//                                    default:
//                                        Text("\(beds) Beds")
//                                    }
//                                }
//                            }
//                        } label: {
//                            VStack {
//                                Image(systemName: "bed.double.fill")
//                                    .font(.system(size: 18, weight: .semibold))
//                                HStack(spacing: 2) {
//                                    Image(systemName: "chevron.down")
//                                    Text("Beds: \(viewModel.realEstate.beds)")
//                                        .font(.system(size: 14, weight: .semibold))
//                                        .minimumScaleFactor(0.5)
//                                }
//                            }
//                            .foregroundColor(.white)
//                            .frame(width: 90, height: 50)
//                            .background(Color.blue)
//                            .cornerRadius(8)
//                        }
//
//                        Menu {
//                            ForEach(0...10, id: \.self) { baths in
//                                Button {
//                                    viewModel.realEstate.baths = baths
//                                } label:  {
//                                    switch baths {
//                                    case 0,1:
//                                        Text("\(baths) bath")
//                                    default:
//                                        Text("\(baths) Baths")
//                                    }
//                                }
//                            }
//                        } label: {
//                            VStack {
//                                Image(systemName: "shower.fill")
//                                    .font(.system(size: 18, weight: .semibold))
//                                HStack(spacing: 2) {
//                                    Image(systemName: "chevron.down")
//                                    Text("Baths: \(viewModel.realEstate.baths)")
//                                        .font(.system(size: 14, weight: .semibold))
//                                        .minimumScaleFactor(0.5)
//                                }
//                            }
//                            .foregroundColor(.white)
//                            .frame(width: 90, height: 50)
//                            .background(Color.orange)
//                            .cornerRadius(8)
//                        }
//
//                        Menu {
//                            ForEach(0...10, id: \.self) { livingRooms in
//                                Button {
//                                    viewModel.realEstate.livingRooms = livingRooms
//                                } label:  {
//                                    switch livingRooms {
//                                    case 0,1:
//                                        Text("\(livingRooms) livingRoom")
//                                    default:
//                                        Text("\(livingRooms) livingRooms")
//                                    }
//                                }
//                            }
//                        } label: {
//                            VStack {
//                                Image(systemName: "sofa.fill")
//                                    .font(.system(size: 18, weight: .semibold))
//                                HStack(spacing: 2) {
//                                    Image(systemName: "chevron.down")
//                                    Text("Rooms: \(viewModel.realEstate.livingRooms)")
//                                        .font(.system(size: 14, weight: .semibold))
//                                        .minimumScaleFactor(0.5)
//                                }
//                            }
//                            .foregroundColor(.white)
//                            .frame(width: 90, height: 50)
//                            .background(Color.purple)
//                            .cornerRadius(8)
//                        }
//
//                        Menu {
//                            ForEach((50...2000).filter{$0.isMultiple(of: 50)}, id: \.self) { spaces in
//                                Button {
//                                    viewModel.realEstate.space = spaces
//                                } label:  {
//                                    switch spaces {
//                                    case 0,1:
//                                        Text("\(spaces) space")
//                                    default:
//                                        Text("\(spaces) spaces")
//                                    }
//                                }
//                            }
//                        } label: {
//                            VStack {
//                                Image(systemName: "ruler.fill")
//                                    .font(.system(size: 18, weight: .semibold))
//                                HStack(spacing: 2) {
//                                    Image(systemName: "chevron.down")
//                                    Text("Area: \(viewModel.realEstate.space)")
//                                        .font(.system(size: 14, weight: .semibold))
//                                        .minimumScaleFactor(0.5)
//                                }
//                            }
//                            .foregroundColor(.white)
//                            .frame(width: 90, height: 50)
//                            .background(Color.gray)
//                            .cornerRadius(8)
//                        }
//                    }
//
//
//                }.padding(.horizontal, 4)
                
                Group{
                    Divider()
                    
                    AmentitiesAddRealEstateView(viewModel: viewModel)
                        .padding(.bottom)
                    Divider()
                        .padding(.bottom)
                }
                    Group{
                        
                        Group{
                            VStack{
                                CustomTitle(title: "Select your Location")
                                
                                HStack{
                                    Text("City:")
                                        .bold()
                                    Spacer()
                                    Menu {
                                        ForEach(City.allCases, id:\.self){ city in
                                            Button {
                                                viewModel.realEstate.city = city
                                            } label: {
                                                Text(city.title)
                                            }
                                            
                                        }
                                    } label: {
                                        HStack{
                                            Text(viewModel.realEstate.city.title)
                                            Image(systemName: "chevron.down")
                                                .foregroundColor(.black)
                                        }
                                    }
                                    
                                }
                            }.padding(.horizontal, 8)
                            
                            
                            VStack{
                                //                            HStack{
                                //                                Text("Type: ")
                                //                                    .foregroundColor(.yellow)
                                //                                Spacer()
                                //                            }
                                HStack{
                                    Text("Facility Type:")
                                        .bold()
                                    Spacer()
                                    Menu {
                                        ForEach(RealEstateType.allCases, id:\.self){ realEstateType in
                                            Button {
                                                viewModel.realEstate.type = realEstateType
                                            } label: {
                                                Label(realEstateType.title, systemImage: realEstateType.imageName)
                                            }
                                            
                                        }
                                    } label: {
                                        HStack{
                                            Text(viewModel.realEstate.type.title)
                                            Image(systemName: viewModel.realEstate.type.imageName)
                                            Image(systemName: "chevron.down")
                                                .foregroundColor(.black)
                                        }
                                    }
                                    
                                }
                            }.padding(.horizontal, 8)
                                .padding(.bottom)
                            //                        Divider()
                            
                            //                        VStack{
                            ////                            HStack{
                            ////                                Text("sale: ")
                            ////                                    .foregroundColor(.yellow)
                            ////                                Spacer()
                            ////                            }
                            ////                            HStack{
                            ////                                Text("offer: ")
                            ////                                Spacer()
                            ////                                Menu {
                            ////                                    ForEach(SaleCategory.allCases, id:\.self){ saleCategory in
                            ////                                        Button {
                            ////                                            viewModel.realEstate.saleCategory = saleCategory
                            ////                                        } label: {
                            ////                                            Label(saleCategory.title, systemImage: saleCategory.imageName)
                            ////                                        }
                            ////
                            ////                                    }
                            ////                                } label: {
                            ////                                    HStack{
                            ////                                        Text( viewModel.realEstate.saleCategory.title)
                            ////                                        Image(systemName:  viewModel.realEstate.saleCategory.imageName)
                            ////                                        Image(systemName: "chevron.down")
                            ////                                            .foregroundColor(.white)
                            ////                                    }
                            ////                                }
                            ////
                            ////                            }.padding(.horizontal , 4)
                            //                        }.padding(.horizontal, 4)
                            
                            //                        Divider()
                            
                            //                        VStack{
                            //                            HStack{
                            //                                Text("price: ")
                            //                                    .foregroundColor(.yellow)
                            //                                Spacer()
                            //                            }
                            //                            HStack{
                            //                                Text("amout: ")
                            //                                Spacer()
                            //                                TextField("0,0" , value: $viewModel.realEstate.price, format: .number)
                            //                                
                            //                            }.padding(.horizontal , 4)
                            //                        }.padding(.horizontal, 4)
                        }.padding(.horizontal, 11)
                    }
                mapUIkitView(realEstate: $viewModel.realEstate)
                    .frame(width:UIScreen.main.bounds.width - 50  , height:250 )
                    .cornerRadius(12)
                       
                //                    ععشان تطلع كل مدينه جديده
                   .id(viewModel.refreshMapViewId)
                    .overlay(
                        Image(systemName: "mappin.and.ellipse")
                            .padding(4)
                            .background(Color.red)
                            .clipShape(Circle())
                        ,alignment: .center
//                        
//                        
                    )     .onChange(of: viewModel.realEstate.city) { _ in
                            self.viewModel.refreshMapViewId = UUID()
                    }.padding(.bottom)
               

//                VStack{
//                    Text("Lat:\(viewModel.realEstate.location.latitude)")
//                    Text("Lat:\(viewModel.realEstate.location.longitude)")
//
////
//
//
//                    }
                }
                NavigationLink {
                    SampleRealEstate(realEstate: $viewModel.realEstate, images: $viewModel.images, coordinateRegion: $viewModel.coordinateRegion,
                                     isShowingAddingRealEstateView: $isShowingAddingRealEstateView)
                    
                } label: {
                    Text("Show Sample before")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: 358, height: 48)
                        .background(Color("Sage"))
                        .mask(RoundedRectangle(cornerRadius: 10, style: .continuous))
                }

               
                
            
//        
//                persininfo(viewModel: viewModel)
                
            }
            .navigationTitle("Add school")
                .navigationBarTitleDisplayMode(.large)
                .toolbar{
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("cancal")
                }
                
            }
        }
        }
    }
}

struct AddRealEstateView_Previews: PreviewProvider {
    static var previews: some View {
        AddRealEstateView(isShowingAddingRealEstateView: .constant(false))
//            .preferredColorScheme(.dark)
            .environmentObject(FirebaseUserManager())
    }
}
struct persininfo: View {
//    @EnvironmentObject var firebaseUserManager : FirebaseUserManager
//    @EnvironmentObject var  firebaseRealEstateManager : FirebaseRealEstateManager
    var viewModel: AddRealEstateViewModel

//    @State var ownrUser = User()
    var body: some View{
        VStack(alignment: .leading, spacing:12 ){
            HStack{
                VStack{
                    Image("people-1")
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
                VStack(alignment: .leading){
                    HStack{
                        Button {
                            
                        } label: {
                            HStack{
                                Image(systemName:"envelope" )
                                Text("Email")
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
//                            Text(firebaseUserManager.user.phoneNumber)
                            
                        }
                        .foregroundColor(.white)
                        .frame(width: 136 , height: 34)
                        .background(Color.indigo)
                        
                    }.buttonStyle(.borderless)
                    
                    
                    
                }
            }.padding(.horizontal ,4)
            
        }
    }
}



struct AmentitiesAddRealEstateView: View {

    var viewModel: AddRealEstateViewModel



    var body: some View {
        VStack(alignment: .leading) {
            CustomTitle(title: "Facilities")
                .padding(.top)
            
            Group{
                    HStack(spacing: 18){

                        Button {
                            viewModel.realEstate.isSmart.toggle()
                        } label: {
                            
                            ZStack{
                                Rectangle()
                                    .fill(.white)
                                    .frame(width: 80, height: 60)
                                    .cornerRadius(8)
                                    .shadow(color: Color(.lightGray), radius:3, x:0, y:2)
                                
                                VStack{
                                    Image(systemName: viewModel.realEstate.isSmart ? "desktopcomputer" : "laptopcomputer")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 20, height: 20)
                                    
                                    
                                    Text("Smart")
                                        .font(.system(size: 12, weight: .semibold))
                                    
                                }
                                
                                    .padding()
                                
                            }

                        }
                        Button {
                            viewModel.realEstate.hasPool.toggle()
                        } label: {
                            
                            ZStack{
                                Rectangle()
                                    .fill(.white)
                                    .frame(width: 80, height: 60)
                                    .cornerRadius(8)
                                    .shadow(color: Color(.lightGray), radius:3, x:0, y:2)
                                VStack{
                                    Image(systemName: viewModel.realEstate.hasPool ? "figure.pool.swim" : "water.waves.slash")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 20, height: 20)
                                    
                                    Text("Pool")
                                        .font(.system(size: 12, weight: .semibold))
                                    
                                }
                                
                                    .padding()
                                
                            }

                        }
                        Button {
                            viewModel.realEstate.hasWiFi.toggle()
                        } label: {
                            
                            ZStack{
                                Rectangle()
                                    .fill(.white)
                                    .frame(width: 80, height: 60)
                                    .cornerRadius(8)
                                    .shadow(color: Color(.lightGray), radius:3, x:0, y:2)
                                VStack{
                                    Image(systemName: viewModel.realEstate.hasWiFi ? "bus.fill": "bus")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 20, height: 20)
                                    
                                    Text("Bus")
                                        .font(.system(size: 12, weight: .semibold))
                                    
                                }
                                
                                    .padding()
                                
                            }

                        }
                        Button {
                            viewModel.realEstate.hasGym.toggle()
                        } label: {
                            
                            ZStack{
                                Rectangle()
                                    .fill(.white)
                                    .frame(width: 80, height: 60)
                                    .cornerRadius(8)
                                    .shadow(color: Color(.lightGray), radius:3, x:0, y:2)
                                VStack{
                                    Image(systemName: viewModel.realEstate.hasGym ? "dumbbell.fill" : "dumbbell")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 20, height: 20)
                                    
                                    Text("Gym")
                                        .font(.system(size: 12, weight: .semibold))
                                    
                                }
                                
                                    .padding()
                                
                            }

                        }
                    }
                
                
                
                //                    VStack(alignment: .center, spacing: 2) {
                //                        Rectangle()
                //                            .fill(.white)
                //                            .frame(width: 66, height: 47)
                //                            .cornerRadius(8)
                //                            .shadow(color: Color(.lightGray), radius:3, x:0, y:2)
                //
                //                        Image(systemName: viewModel.realEstate.isSmart ? "entry.lever.keypad.fill" : "entry.lever.keypad")
                //                            .resizable()
                //                            .scaledToFill()
                //                            .frame(width: 24, height: 24)
                //
                //                        Text("Smart")
                //                            .font(.system(size: 12, weight: .semibold))
                //                            .padding(.top, 8)
                //
                //
                ////                        Image(systemName: viewModel.realEstate.isSmart ? "checmark.square.fill" : "square")
                ////                            .foregroundColor(viewModel.realEstate.isSmart ? .green : .black)
                ////                            .padding(.top, 4)
                //                    }
                //
                //                        //
                //                        .foregroundColor(Color("Sage"))
                
                
                //                            }
                //                .frame(width: 66 , height: 47)
                //                .padding()
                //                .background(.white)
                //                                                        .cornerRadius(8)
                //                                                        .shadow(color: Color(.lightGray), radius:3, x:0, y:2)
                
                
                
                //            HStack(spacing: 8){
                //
                //                Button {
                //                    viewModel.realEstate.isSmart.toggle()
                //                } label: {
                //                    VStack(alignment: .center, spacing: 2) {
                //                        Image(systemName: "entry.lever.keypad.fill")
                //                            .resizable()
                //                            .scaledToFill()
                //                            .frame(width: 30, height: 30)
                //
                //                        Text("Smart")
                //                            .font(.system(size: 14, weight: .semibold))
                //                            .padding(.top, 8)
                //
                //                        Image(systemName: viewModel.realEstate.isSmart ? "checmark.square.fill" : "square")
                //                            .foregroundColor(viewModel.realEstate.isSmart ? .green : .black)
                //                            .padding(.top, 4)
                //                    }.frame(width: 60)
                //                        .foregroundColor(.black)
                //                }.buttonStyle(.borderless)
                //
                //
                //                Divider()
                //
                //                Button {
                //                    viewModel.realEstate.hasWiFi.toggle()
                //                } label: {
                //                    VStack(alignment: .center, spacing: 2) {
                //                        Image(systemName: "wifi")
                //                            .resizable()
                //                            .scaledToFill()
                //                            .frame(width: 30, height: 30)
                //
                //                        Text("Wifi")
                //                            .font(.system(size: 14, weight: .semibold))
                //                            .padding(.top, 8)
                //
                //                        Image(systemName: viewModel.realEstate.hasWiFi ? "checmark.square.fill" : "square")
                //                            .foregroundColor(viewModel.realEstate.hasWiFi ? .green : .black)
                //                            .padding(.top, 4)
                //                    }.frame(width: 60)
                //                        .foregroundColor(.black)
                //                }.buttonStyle(.borderless)
                //
                //                Divider()
                //
                //                Button {
                //                    viewModel.realEstate.hasPool.toggle()
                //                } label: {
                //                    VStack(alignment: .center, spacing: 2) {
                //                        Image(systemName: "figure.pool.swim")
                //                            .resizable()
                //                            .scaledToFill()
                //                            .frame(width: 30, height: 30)
                //
                //                        Text("Pool")
                //                            .font(.system(size: 14, weight: .semibold))
                //                            .padding(.top, 8)
                //
                //                        Image(systemName: viewModel.realEstate.hasPool ? "checmark.square.fill" : "square")
                //                            .foregroundColor(viewModel.realEstate.hasPool ? .green : .black)
                //                            .padding(.top, 4)
                //                    }.frame(width: 60)
                //                        .foregroundColor(.black)
                //                }.buttonStyle(.borderless)
                //
                //                Divider()
                //
                //                Button {
                //                    viewModel.realEstate.hasElevator.toggle()
                //                } label: {
                //                    VStack(alignment: .center, spacing: 2) {
                //                        Image(systemName: "figure.walk.arrival")
                //                            .resizable()
                //                            .scaledToFill()
                //                            .frame(width: 30, height: 30)
                //
                //                        Text("Elevator")
                //                            .font(.system(size: 14, weight: .semibold))
                //                            .padding(.top, 8)
                //
                //                        Image(systemName: viewModel.realEstate.hasElevator ? "checmark.square.fill" : "square")
                //                            .foregroundColor(viewModel.realEstate.hasElevator ? .green : .black)
                //                            .padding(.top, 4)
                //                    }.frame(width: 60)
                //                        .foregroundColor(.black)
                //                }.buttonStyle(.borderless)
                //
                //                Divider()
                //
                //                Button {
                //                    viewModel.realEstate.hasGym.toggle()
                //                } label: {
                //                    VStack(alignment: .center, spacing: 2) {
                //                        Image(systemName: "dumbbell.fill")
                //                            .resizable()
                //                            .scaledToFill()
                //                            .frame(width: 30, height: 30)
                //
                //                        Text("Gym")
                //                            .font(.system(size: 14, weight: .semibold))
                //                            .padding(.top, 8)
                //
                //                        Image(systemName: viewModel.realEstate.hasGym ? "checmark.square.fill" : "square")
                //                            .foregroundColor(viewModel.realEstate.hasGym ? .green : .black)
                //                            .padding(.top, 4)
                //                    }.frame(width: 60)
                //                        .foregroundColor(.black)
                //                }.buttonStyle(.borderless)
                //            }
                
                //                                HStack {
                //                                    RoundedRectangle(cornerRadius: 12)
                //                                        .fill(Color.gray.opacity(0.2))
                //                                        .frame(maxWidth: .infinity)
                //                                        .frame(height: 1)
                //
                //                                    Menu {
                //                                        ForEach(0...10, id: \.self) { age in
                //                                            Button {
                //                                                viewModel.realEstate.age = age
                //                                            } label: {
                //                                                switch age {
                //                                                case 0,1:
                //                                                    Text("\(age) Year")
                //                                                default:
                //                                                    Text("\(age) Years")
                //                                                }
                //                                            }
                //                                        }
                //                                    } label: {
                //                                        VStack(spacing: 2) {
                //                                            Image(systemName: "building.2.fill")
                //                                                .resizable()
                //                                                .scaledToFill()
                //                                                .frame(width: 30, height: 30)
                //
                //                                            HStack(spacing: 2) {
                //                                                Image(systemName: "chevron.down")
                //                                                Text("\(viewModel.realEstate.age) Years")
                //                                                    .font(.system(size: 14, weight: .semibold))
                //                                            }.padding(.top, 6)
                //                                        }.padding(.horizontal, 10)
                //                                    }.foregroundColor(.white)
                //                                        .padding(.top, 8)
                //
                //
                //                                    RoundedRectangle(cornerRadius: 12)
                //                                        .fill(Color.gray.opacity(0.2))
                //                                        .frame(maxWidth: .infinity)
                //                                        .frame(height: 1)
                //                                }.padding(.top, 16)
            }
                            }.padding(.horizontal, 16)
                        }
                    
        }
 



import MapKit

struct mapUIkitView: UIViewRepresentable{
    
    @Binding var realEstate : RealEstate
    let mapView = MKMapView()
    
    func makeUIView(context: Context) ->  MKMapView {
       
        mapView.delegate = context.coordinator
        
        
        mapView.setRegion(.init(center: realEstate.city.coordinate, span: realEstate.city.zoomLevel), animated: true)
        return mapView
    }
    func updateUIView(_ uiView: MKMapView, context: Context) {
        
    }
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    class Coordinator : NSObject, MKMapViewDelegate , UIGestureRecognizerDelegate{
        var parent: mapUIkitView
        var gRecognizer = UILongPressGestureRecognizer()
        
        init(_ parent: mapUIkitView){
            self.parent = parent
            super.init()
//             if want to make usr taP TO HOLD TO GET LOCATION
        }
        
        func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
//            print("Dueubg: user coordinets\(mapView.centerCoordinate)")
            self.parent.realEstate.location = mapView.centerCoordinate
        }
    }
}

import SwiftUI

/// Image Picker Representable
///
struct ImagePicker: UIViewControllerRepresentable {
    
    typealias imagePickerController = UIImagePickerController
    
    @Binding var image: UIImage?
    @Binding var isShown: Bool

    var sourceType: UIImagePickerController.SourceType = .camera
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.delegate = context.coordinator
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(image: $image, isShown: $isShown)
    }
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        
        @Binding var image: UIImage?
        @Binding var isShown: Bool
        var sourceType: UIImagePickerController.SourceType = .camera
        
        init(image: Binding<UIImage?    >, isShown: Binding<Bool>) {
            _image = image
            _isShown = isShown
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                image = uiImage
                isShown = false
            }
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            isShown = false
        }
    }
}

