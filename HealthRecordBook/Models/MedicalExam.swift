//
//  MedicalExam.swift
//  HealthRecordBook
//
//  Created by Rafał Kwiecień on 02/11/2023.
//

import Foundation

struct MedicalExam: Codable, Identifiable {
    var id: String
    var patientID: String
    var date: Date
    var type: String
    var results: String
    var doctorNotes: String?
}
