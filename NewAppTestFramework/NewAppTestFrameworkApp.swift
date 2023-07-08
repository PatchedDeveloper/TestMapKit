//
//  NewAppTestFrameworkApp.swift
//  NewAppTestFramework
//
//  Created by Danila Kardashevkii on 02.07.2023.
//

import SwiftUI
import Firebase
import FirebaseAuth

let screen = UIScreen.main.bounds

@main
struct NewAppTestFrameworkApp: App {
    
    @UIApplicationDelegateAdaptor private var appDelegate : AppDelegate
    
    var body: some Scene {
        WindowGroup {
            AuthView()
        }
    }
    
    class AppDelegate: NSObject,UIApplicationDelegate {
        func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
            
            FirebaseApp.configure()
            print("firebase configure ok")
            return true
        }
    }
}
