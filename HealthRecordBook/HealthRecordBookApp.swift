//
//  HealthRecordBookApp.swift
//  HealthRecordBook
//
//  Created by Rafał Kwiecień on 01/11/2023.
//

import SwiftUI
import Firebase

@main
struct HealthRecordBookApp: App {
    
    init () {
        FirebaseApp.configure()
        print("Configured Firebase")
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
