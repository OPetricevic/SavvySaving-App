//
//  SavvySavingApp.swift
//  SavvySaving
//
//  Created by Omar Petričević on 05.07.2023..
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
      FirebaseApp.configure()
      
      let db = Firestore.firestore()
      
      print(db)
      
    return true
  }
}

@main
struct SavvySavingApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @AppStorage("isDarkMode") private var isDarkMode = false

    var body: some Scene {
        WindowGroup {
            RootView().preferredColorScheme(isDarkMode ?.dark : .light)
        }
    }
}
