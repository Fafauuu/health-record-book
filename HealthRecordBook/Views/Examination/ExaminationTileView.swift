//
//  MedicalVisitTileView.swift
//  HealthRecordBook
//
//  Created by Rafał Kwiecień on 13/11/2023.
//

import SwiftUI

struct ExaminationTileView: View {
    let examination: Examination
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(examination.name)
                .font(.headline)
            Text(examination.date, style: .date)
                .font(.subheadline)
        }
    }
}

