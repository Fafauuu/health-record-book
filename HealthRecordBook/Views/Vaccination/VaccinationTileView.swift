//
//  MedicalExamTileView.swift
//  HealthRecordBook
//
//  Created by Rafał Kwiecień on 04/11/2023.
//

import SwiftUI

struct VaccinationTileView: View {
    let vaccination: Vaccination
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(vaccination.type)
                .font(.headline)
            Text(vaccination.date, style: .date)
                .font(.subheadline)
        }
    }
}
