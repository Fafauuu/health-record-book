//
//  MedicalVisitService.swift
//  HealthRecordBook
//
//  Created by Rafał Kwiecień on 13/11/2023.
//


import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

final class ExaminationService {
    static let shared = ExaminationService()
    
    private let collection = "examinations"
    
    private init() {}
    
    func createExamination(for patientID: String, exam: Examination) async throws -> String {
        let db = Firestore.firestore()
        let examData: [String: Any] = [
            "patientID": patientID,
            "date": Timestamp(date: exam.date),
            "name": exam.name,
            "specialist": exam.specialist,
            "diagnosis": exam.diagnosis,
            "recommendations": exam.recommendations,
            "prescriptions": exam.prescriptions ?? "",
            "doctorNotes": exam.doctorNotes ?? ""
        ]
        let documentRef = db.collection(collection).document()
        try await documentRef.setData(examData)
        return documentRef.documentID
    }
    
    func getExaminations(for patientID: String) async throws -> [Examination] {
        let db = Firestore.firestore()
        let querySnapshot = try await db.collection(collection)
            .whereField("patientID", isEqualTo: patientID)
            .getDocuments()
        let exams = querySnapshot.documents.compactMap { document -> Examination? in
            try? document.data(as: Examination.self)
        }
        return exams
    }
    
    func updateExamination(_ exam: Examination) async throws {
        let db = Firestore.firestore()
        let document = db.collection(collection).document(exam.id)
        try document.setData(from: exam)
    }
    
    func deleteExamination(_ exam: Examination) async throws {
        let db = Firestore.firestore()
        let document = db.collection(collection).document(exam.id)
        try await document.delete()
    }
}
