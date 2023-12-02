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
            VStack(alignment: .leading, spacing: 15) {
                GroupBox(label: Text("Typ szczepienia").fontWeight(.bold)) {
                    VStack(alignment: .leading, spacing: 5) {
                        Text(vaccination.type)
                            .font(.body)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }

                GroupBox(label: Text("Data").fontWeight(.bold)) {
                    VStack(alignment: .leading, spacing: 5) {
                        Text(vaccination.date, formatter: dateFormatter)
                            .font(.body)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }

                if let sideEffects = vaccination.sideEffects {
                    GroupBox(label: Text("Skutki uboczne").fontWeight(.bold)) {
                        VStack(alignment: .leading, spacing: 5) {
                            Text(sideEffects)
                                .font(.body)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Szczegóły Szczepienia")
    }
}

