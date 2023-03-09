//
//  FirebaseApp.swift
//  Weath App
//
//  Created by Setthasit Poosawat on 5/3/23.
//

import Firebase

class FirebaseAppManager {
    static let shared = FirebaseAppManager()

    private init() {
        FirebaseApp.configure()
    }
}


