//
//  MedicalExamService.swift
//  HealthRecordBook
//
//  Created by Rafał Kwiecień on 04/11/2023.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

final class VaccinationService {
    static let shared = VaccinationService()
    private let collection = "vaccinations"
    
    private init() {}
    
    func createVaccination(for patientID: String, vaccination: Vaccination) async throws -> String {
        let db = Firestore.firestore()
        let vaccinationData: [String: Any] = [
            "patientID": patientID,
            "date": Timestamp(date: vaccination.date),
            "type": vaccination.type,
            "sideEffects": vaccination.sideEffects ?? ""
        ]
        let documentRef = db.collection(collection).document()
        try await documentRef.setData(vaccinationData)
        return documentRef.documentID
    }
    
    func getVaccinations(for patientID: String) async throws -> [Vaccination] {
        let db = Firestore.firestore()
        let querySnapshot = try await db.collection(collection)
            .whereField("patientID", isEqualTo: patientID)
            .getDocuments()
        let vaccinations = querySnapshot.documents.compactMap { document -> Vaccination? in
            try? document.data(as: Vaccination.self)
        }
        return vaccinations
    }
    
    func updateVaccination(_ vaccination: Vaccination) async throws {
        let db = Firestore.firestore()
        let document = db.collection(collection).document(vaccination.id)
        try document.setData(from: vaccination)
    }
    
    func deleteVaccination(_ vaccination: Vaccination) async throws {
        let db = Firestore.firestore()
        let document = db.collection(collection).document(vaccination.id)
        try await document.delete()
    }
}
