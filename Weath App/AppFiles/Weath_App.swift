//
//  Weath_AppApp.swift
//  Weath App
//
//  Created by Yadar Tulayathamrong on 2/3/2566 BE.
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
