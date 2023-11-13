//
//  Vaccination.swift
//  HealthRecordBook
//
//  Created by Rafał Kwiecień on 02/11/2023.
//

import Foundation

struct Vaccination: Codable, Identifiable {
    var id: String
    var patientID: String
    var date: Date
    var type: String
    var sideEffects: String?
}
