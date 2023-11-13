//
//  MedicalVisitAddView.swift
//  HealthRecordBook
//
//  Created by Rafał Kwiecień on 13/11/2023.
//

import SwiftUI

struct ExaminationAddView: View {
    @Environment(\.presentationMode) var presentationMode
    var patientID: String

    @State private var date = Date()
    @State private var name = ""
    @State private var specialist = ""
    @State private var diagnosis = ""
    @State private var recommendations = ""
    @State private var prescriptions = ""
    @State private var doctorNotes = ""

    var body: some View {
        NavigationView {
            Form {
                DatePicker("Data", selection: $date, displayedComponents: .date)
                TextField("Nazwa badania/wizyty", text: $name)
                TextField("Specjalista", text: $specialist)
                TextField("Diagnoza", text: $diagnosis)
                TextField("Rekomendacje", text: $recommendations)
                TextField("Przypisane lekarstwa", text: $prescriptions)
                TextField("Notatki lekarza", text: $doctorNotes)

                Button("Dodaj") {
                    addExamination()
                }
            }
            .navigationBarTitle("Dodaj Badanie/Wizytę", displayMode: .inline)
            .navigationBarItems(trailing: Button("Zamknij") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }

    private func addExamination() {
        let newExamination = Examination(
            id: "",
            patientID: patientID,
            date: date,
            name: name,
            specialist: specialist,
            diagnosis: diagnosis,
            recommendations: recommendations,
            prescriptions: prescriptions.isEmpty ? nil : prescriptions,
            doctorNotes: doctorNotes.isEmpty ? nil : doctorNotes
        )

        Task {
            do {
                let documentID = try await ExaminationService.shared.createExamination(for: patientID, exam: newExamination)
                var updatedExamination = newExamination
                updatedExamination.id = documentID
                try await ExaminationService.shared.updateExamination(updatedExamination)
                presentationMode.wrappedValue.dismiss()
            } catch {
                print("Error adding examination: \(error)")
            }
        }
    }
}

struct ExaminationAddView_Previews: PreviewProvider {
    static var previews: some View {
        ExaminationAddView(patientID: "12345")
    }
}
