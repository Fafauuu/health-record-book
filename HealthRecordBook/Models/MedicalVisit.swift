//
//  MedicalVisit.swift
//  HealthRecordBook
//
//  Created by Rafał Kwiecień on 02/11/2023.
//

import Foundation

struct MedicalVisit {
    var id: String
    var patientID: String
    var date: Date
    var specialist: String
    var diagnosis: String
    var recommendations: String
    var prescriptions: String?
}
