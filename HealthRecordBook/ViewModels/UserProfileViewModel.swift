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
        guard let userId = SessionManager.shared.getUserId() else { return }
        let fetchedUser = try await UserService.shared.getUser(userId: userId)
        
        DispatchQueue.main.async {
            print(fetchedUser)
            self.user = fetchedUser
        }
    }
}
