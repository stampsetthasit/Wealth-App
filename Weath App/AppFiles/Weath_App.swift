//
//  Weath_AppApp.swift
//  Weath App
//
//  Created by Setthasit Poosawat on 5/3/23.
//

import SwiftUI
import Firebase

@main
struct Weath_App: App {
//    let firebaseApp = FirebaseApp.shared
    
    var body: some Scene {
        WindowGroup {
            HomeView()
        }
    }
    
    // MARK: - Initialize Firebase
    init() {
        FirebaseApp.configure()
    }
}
