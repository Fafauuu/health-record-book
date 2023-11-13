//
//  AppointmentService.swift
//  HealthRecordBook
//
//  Created by Rafał Kwiecień on 13/11/2023.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

final class AppointmentService {
    static let shared = AppointmentService()
    private let collection = "appointments"
    
    private init() {}
    
    func createAppointment(for patientID: String, appointment: Appointment) async throws -> String {
        let db = Firestore.firestore()
        let appointmentData: [String: Any] = [
            "patientID": patientID,
            "date": Timestamp(date: appointment.date),
            "type": appointment.type,
            "location": appointment.location,
            "specialist": appointment.specialist
        ]
        let documentRef = db.collection(collection).document()
        try await documentRef.setData(appointmentData)
        return documentRef.documentID
    }
    
    func getAppointments(for patientID: String) async throws -> [Appointment] {
        let db = Firestore.firestore()
        let now = Timestamp(date: Date())
        let querySnapshot = try await db.collection(collection)
            .whereField("patientID", isEqualTo: patientID)
            .whereField("date", isGreaterThan: now)
            .getDocuments()
        let appointments = querySnapshot.documents.compactMap { document -> Appointment? in
            try? document.data(as: Appointment.self)
        }
        return appointments
    }
    
    func getPastAppointments(for patientID: String) async throws -> [Appointment] {
        print("fetching past appointments")
        let db = Firestore.firestore()
        let querySnapshot = try await db.collection(collection)
            .whereField("patientID", isEqualTo: patientID)
            .whereField("date", isLessThan: Timestamp(date: Date()))
            .getDocuments()
        let appointments = querySnapshot.documents.compactMap { document -> Appointment? in
            try? document.data(as: Appointment.self)
        }
        return appointments
    }
    
    func updateAppointment(_ appointment: Appointment) async throws {
        let db = Firestore.firestore()
        let document = db.collection(collection).document(appointment.id)
        try document.setData(from: appointment)
    }
    
    func deleteAppointment(_ appointment: Appointment) async throws {
        let db = Firestore.firestore()
        let document = db.collection(collection).document(appointment.id)
        try await document.delete()
    }
}
