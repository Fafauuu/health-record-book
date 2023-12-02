//
//  MedicalVisitDetailView.swift
//  HealthRecordBook
//
//  Created by Rafał Kwiecień on 13/11/2023.
//

import SwiftUI

struct ExaminationDetailView: View {
    let examination: Examination
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 15) {
                GroupBox(label: Text("Nazwa wizyty").fontWeight(.bold)) {
                    VStack(alignment: .leading, spacing: 5) {
                        Text(examination.name)
                            .font(.body)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }

                GroupBox(label: Text("Data").fontWeight(.bold)) {
                    VStack(alignment: .leading, spacing: 5) {
                        Text(examination.date, formatter: dateFormatter)
                            .font(.body)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }

                GroupBox(label: Text("Specjalista").fontWeight(.bold)) {
                    VStack(alignment: .leading, spacing: 5) {
                        Text(examination.specialist)
                            .font(.body)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }

                GroupBox(label: Text("Diagnoza").fontWeight(.bold)) {
                    VStack(alignment: .leading, spacing: 5) {
                        Text(examination.diagnosis)
                            .font(.body)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }

                GroupBox(label: Text("Rekomendacje").fontWeight(.bold)) {
                    VStack(alignment: .leading, spacing: 5) {
                        Text(examination.recommendations)
                            .font(.body)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }

                if let prescriptions = examination.prescriptions {
                    GroupBox(label: Text("Przypisane lekarstwa").fontWeight(.bold)) {
                        VStack(alignment: .leading, spacing: 5) {
                            Text(prescriptions)
                                .font(.body)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                
                if let doctorNotes = examination.doctorNotes {
                    GroupBox(label: Text("Notatki lekarza").fontWeight(.bold)) {
                        VStack(alignment: .leading, spacing: 5) {
                            Text(doctorNotes)
                                .font(.body)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Szczegóły")
    }
}




struct ExaminationDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ExaminationDetailView(examination: Examination(
            id: "123",
            patientID: "patient123",
            date: Date(),
            name: "Testowe Badanie",
            specialist: "Dr. Kowalski",
            diagnosis: "Zdrowy",
            recommendations: "Brak",
            prescriptions: "Witamina C",
            doctorNotes: "Brak uwag"
        ))
    }
}

