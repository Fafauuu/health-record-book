//
//  HomeViewModel.swift
//  HealthRecordBook
//
//  Created by Rafał Kwiecień on 01/11/2023.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var isLogged = false
    var users: [User] = [User(email: "Login", password: "123")]
    
    func login(email: String, password: String) {
        if let _ = users.first(where: { $0.email == email && $0.password == password }) {
            self.isLogged = true
        }
    }
    
    func register(email: String, password: String) {
        let newUser = User(email: email, password: password)
        self.users.append(newUser)
    }
    
    func logout() {
        self.isLogged = false
    }
}
