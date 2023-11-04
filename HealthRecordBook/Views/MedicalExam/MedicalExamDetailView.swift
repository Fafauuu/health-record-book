//
//  MedicalExamDetailView.swift
//  HealthRecordBook
//
//  Created by Rafał Kwiecień on 04/11/2023.
//

import SwiftUI

struct MedicalExamDetailView: View {
    let exam: MedicalExam
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                Text("Typ badania: \(exam.type)")
                    .font(.headline)
                Text("Data: \(exam.date, style: .date)")
                Text("Wyniki: \(exam.results)")
                if let doctorNotes = exam.doctorNotes {
                    Text("Notatki lekarza: \(doctorNotes)")
                }
            }
            .padding()
        }
        .navigationTitle("Szczegóły Badania")
    }
}
