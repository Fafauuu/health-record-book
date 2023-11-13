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
            VStack(alignment: .leading, spacing: 10) {
                Group {
                    Text("Nazwa wizyty: \(examination.name)")
                    Text("Data: \(examination.date, formatter: dateFormatter)")
                    Text("Specjalista: \(examination.specialist)")
                    Text("Diagnoza: \(examination.diagnosis)")
                    Text("Rekomendacje: \(examination.recommendations)")
                }.font(.title2)
                
                if let prescriptions = examination.prescriptions {
                    Text("Przypisane lekarstwa: \(prescriptions)")
                }
                
                if let doctorNotes = examination.doctorNotes {
                    Text("Notatki lekarza: \(doctorNotes)")
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

