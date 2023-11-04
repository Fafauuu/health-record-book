//
//  MedicalExamTileView.swift
//  HealthRecordBook
//
//  Created by Rafał Kwiecień on 04/11/2023.
//

import SwiftUI

struct MedicalExamTileView: View {
    let exam: MedicalExam
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text(exam.type)
                    .font(.headline)
                Text(exam.date, style: .date)
                    .font(.subheadline)
            }
            Spacer()
        }
    }
}
