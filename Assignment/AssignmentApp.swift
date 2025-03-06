//
//  AssignmentApp.swift
//  Assignment
//
//  Created by Denver Alfito Anggada on 26/12/2022.
//

import SwiftUI
import Firebase
@main
struct AssignmentApp: App {
    
    @StateObject var firestoreManager = FirestoreManager()
    
    init(){
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            if UserDefaults.standard.object(forKey: "user_uid_key") != nil {
                WelcomeScreen().navigationBarBackButtonHidden(true)
                    .navigationBarTitleDisplayMode(.inline)
                    .environmentObject(firestoreManager)
            }
            else{
                ContentView()
                    .environmentObject(firestoreManager)
            }
        }
    }
}

struct FirebaseLoginApp: App{
    
    init(){
        FirebaseApp.configure()
    }
    var body: some Scene{
        WindowGroup{
            ContentView()
        }
    }
}
