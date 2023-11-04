//
//  UserMenager.swift
//  HealthRecordBook
//
//  Created by Rafał Kwiecień on 01/11/2023.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

final class UserService {
    static let shared = UserService()
    
    private init() {}
    
    func createNewUser(auth: AuthDataResultModel) async throws {
        let userData: [String: Any] = [
            "id": auth.uid,
            "firstName": "",
            "lastName": "",
            "dateOfBirth": Timestamp(date: Date(timeIntervalSince1970: 0)),
            "height": 0,
            "weight": 0,
            "bloodType": "",
            "allergies": [],
            "chronicDiseases": []
        ]
        
        try await Firestore.firestore().collection("users").document(auth.uid).setData(userData, merge: false)
    }

    
    func getUser(userId: String) async throws -> UserDTO {
        let snapshot = try await Firestore.firestore().collection("users").document(userId).getDocument()
        
        guard let data = snapshot.data() else {
            throw URLError(.badServerResponse)
        }
        
        let dateOfBirthTimestamp = data["dateOfBirth"] as? Timestamp
        let dateOfBirth = dateOfBirthTimestamp?.dateValue() ?? Date(timeIntervalSince1970: 0)
        
        let height = (data["height"] as? NSNumber)?.doubleValue ?? 0
        let weight = (data["weight"] as? NSNumber)?.doubleValue ?? 0
        let bloodType = data["bloodType"] as? String ?? ""
        let allergies = data["allergies"] as? [String] ?? []
        let chronicDiseases = data["chronicDiseases"] as? [String] ?? []

        return UserDTO(
            id: userId,
            firstName: data["firstName"] as? String ?? "",
            lastName: data["lastName"] as? String ?? "",
            dateOfBirth: dateOfBirth,
            height: height,
            weight: weight,
            bloodType: bloodType,
            allergies: allergies,
            chronicDiseases: chronicDiseases
        )
    }
    
    func updateUser(user: UserDTO) async throws {
        let documentRef = Firestore.firestore().collection("users").document(user.id)
        
        let dateOfBirthTimestamp = Timestamp(date: user.dateOfBirth)

        let userData: [String: Any] = [
            "firstName": user.firstName,
            "lastName": user.lastName,
            "dateOfBirth": dateOfBirthTimestamp,
            "height": user.height,
            "weight": user.weight,
            "bloodType": user.bloodType,
            "allergies": user.allergies ?? [],
            "chronicDiseases": user.chronicDiseases ?? []
        ]
        
        try await documentRef.setData(userData, merge: true)
    }
}
