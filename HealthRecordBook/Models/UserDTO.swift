//
//  User.swift
//  HealthRecordBook
//
//  Created by Rafał Kwiecień on 01/11/2023.
//

import Foundation

struct UserDTO {
    var id: String
    var firstName: String
    var lastName: String
    var dateOfBirth: Date
    var height: Double
    var weight: Double
    var bloodType: String
    var allergies: [String]?
    var chronicDiseases: [String]?
}
