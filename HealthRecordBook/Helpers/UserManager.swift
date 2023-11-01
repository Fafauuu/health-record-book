//
//  UserMenager.swift
//  HealthRecordBook
//
//  Created by Rafał Kwiecień on 01/11/2023.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

final class UserManager {
    static let shared = UserManager()
    
    private init() {}
    
    func createNewUser(auth: AuthDataResultModel) async throws{
        let userData: [String:Any] = [
            "user_id": auth.uid,
            "date_created": Timestamp()
        ]
        try await Firestore.firestore().collection("users").document(auth.uid).setData(userData, merge: false)
    }
    
    func getUser(userId: String) async throws -> UserDTO {
        let snapshot = try await Firestore.firestore().collection("users").document(userId).getDocument()
        
        guard let data = snapshot.data(), let userId = data["user_id"] as? String else {
            throw URLError(.badServerResponse)
        }
        
        let timestamp = data["date_created"] as? Timestamp
        let dateCreated = timestamp?.dateValue()
        
        return UserDTO(userId: userId, dateCreated: dateCreated)
    }
}
