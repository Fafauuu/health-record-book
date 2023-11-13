//
//  MedicalExamDetailView.swift
//  HealthRecordBook
//
//  Created by Rafał Kwiecień on 04/11/2023.
//

import SwiftUI

struct VaccinationDetailView: View {
    let vaccination: Vaccination
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                Group {
                    Text("Typ szczepienia: \(vaccination.type)")
                    Text("Data: \(vaccination.date, formatter: dateFormatter)")
                }.font(.title2)
                
                if let sideEffects = vaccination.sideEffects {
                    Text("Skutki uboczne: \(sideEffects)")
                }
            }
            .padding()
        }
        .navigationTitle("Szczegóły Szczepienia")
    }
}
