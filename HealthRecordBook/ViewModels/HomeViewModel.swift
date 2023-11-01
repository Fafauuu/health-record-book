//
//  HomeViewModel.swift
//  HealthRecordBook
//
//  Created by Rafał Kwiecień on 01/11/2023.
//

import Foundation
import FirebaseAuth

struct AuthDataResultModel {
    let uid: String
    let email: String?
    
    init(user: User) {
        self.uid = user.uid
        self.email = user.email
    }
}

class HomeViewModel: ObservableObject {
    @Published var isLogged = false
    
    func register(email: String, password: String) async throws {
        let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
        let result = AuthDataResultModel(user: authDataResult.user)
        print(result)
    }
    
    func login(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard let self = self else { return }
            if let error = error {
                print("Error: \(error.localizedDescription)")
            } else {
                self.isLogged = true
                print("Login successful!")
            }
        }
    }
    
    func logout() {
        do {
            try Auth.auth().signOut()
            self.isLogged = false
            print("Logout successful!")
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
//    func login(email: String, password: String) {
//        print("Login")
//        self.isLogged = true
////        if let _ = users.first(where: { $0.email == email && $0.password == password }) {
////            self.isLogged = true
////        }
//    }
//
//    func logout() {
//        print("Login")
//        self.isLogged = false
//    }
//
//    func getAuthenticatedUser() throws -> AuthDataResultModel {
//        guard let user = Auth.auth().currentUser else {
//            throw URLError(.badServerResponse)
//        }
//        return AuthDataResultModel(user: user)
//    }
}
