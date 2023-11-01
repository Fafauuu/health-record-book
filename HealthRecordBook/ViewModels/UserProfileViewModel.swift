//
//  UserProfileViewModel.swift
//  HealthRecordBook
//
//  Created by Rafał Kwiecień on 01/11/2023.
//

import Foundation


class UserProfileViewModel: ObservableObject {
    @Published var user: UserDTO? = nil
    
    func loadCurrentUser() async throws {
        let authDataResult = try AuthenticationManager.shared.getAuthenticatedUser()
        let fetchedUser = try await UserManager.shared.getUser(userId: authDataResult.uid)
        
        DispatchQueue.main.async {
            print(fetchedUser)
            self.user = fetchedUser
        }
    }
}

