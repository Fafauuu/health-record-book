//
//  Appointment.swift
//  HealthRecordBook
//
//  Created by Rafał Kwiecień on 02/11/2023.
//

import Foundation

struct Appointment: Codable, Identifiable {
    var id: String
    var patientID: String
    var date: Date
    var type: String
    var location: String
    var specialist: String
}
