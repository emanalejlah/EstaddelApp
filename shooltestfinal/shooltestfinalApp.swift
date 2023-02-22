//
//  shooltestfinalApp.swift
//  shooltestfinal
//
//  Created by eman alejilah on 26/07/1444 AH.
//

import SwiftUI
import Firebase


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()


    return true
  }
}



@main
struct shooltestfinalApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var firebaseUserManager = FirebaseUserManager ()
    @StateObject var firebaseRealEstateManager =  FirebaseRealEstateManager()
    var body: some Scene {
        WindowGroup {
            LoadingView()
       .environmentObject(FirebaseUserManager())
       .environmentObject(FirebaseRealEstateManager())
        }
    }
}
