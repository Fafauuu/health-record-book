//
//  Visit.swift
//  HealthRecordBook
//
//  Created by Rafał Kwiecień on 13/11/2023.
//

import Foundation

struct Examination: Codable, Identifiable {
    var id: String
    var patientID: String
    var date: Date
    var name: String
    var specialist: String
    var diagnosis: String
    var recommendations: String
    var prescriptions: String?
    var doctorNotes: String?
}
