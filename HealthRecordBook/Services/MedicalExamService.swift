//
//  MedicalExamService.swift
//  HealthRecordBook
//
//  Created by Rafał Kwiecień on 04/11/2023.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

final class MedicalExamService {
    static let shared = MedicalExamService()
    
    private let collection = "medicalExams"
    
    private init() {}
    
    func createMedicalExam(for patientID: String, exam: MedicalExam) async throws -> String {
        let db = Firestore.firestore()
        let examData: [String: Any] = [
            "patientID": patientID,
            "date": Timestamp(date: exam.date),
            "type": exam.type,
            "results": exam.results,
            "doctorNotes": exam.doctorNotes ?? ""
        ]
        let documentRef = db.collection(collection).document()
        try await documentRef.setData(examData)
        return documentRef.documentID
    }
    
    func getMedicalExams(for patientID: String) async throws -> [MedicalExam] {
        let db = Firestore.firestore()
        let querySnapshot = try await db.collection(collection)
            .whereField("patientID", isEqualTo: patientID)
            .getDocuments()
        let exams = querySnapshot.documents.compactMap { document -> MedicalExam? in
            try? document.data(as: MedicalExam.self)
        }
        return exams
    }
    
    func updateMedicalExam(_ exam: MedicalExam) async throws {
        let db = Firestore.firestore()
        let document = db.collection(collection).document(exam.id)
        try document.setData(from: exam)
    }
    
    func deleteMedicalExam(_ exam: MedicalExam) async throws {
        let db = Firestore.firestore()
        let document = db.collection(collection).document(exam.id)
        try await document.delete()
    }
}
