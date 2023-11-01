//
//  HomeViewModel.swift
//  HealthRecordBook
//
//  Created by Rafał Kwiecień on 01/11/2023.
//

import Foundation
import FirebaseAuth


class HomeViewModel: ObservableObject {
    @Published var isLogged = false
    
    func register(email: String, password: String) async throws {
        let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
        let result = AuthDataResultModel(user: authDataResult.user)
        try await UserManager.shared.createNewUser(auth: result)
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
}
