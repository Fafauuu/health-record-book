//
//  MedicalExamAddView.swift
//  HealthRecordBook
//
//  Created by Rafał Kwiecień on 04/11/2023.
//

import SwiftUI

struct MedicalExamAddView: View {
    @Environment(\.presentationMode) var presentationMode
    var patientID: String

    @State private var date = Date()
    @State private var type = ""
    @State private var results = ""
    @State private var doctorNotes = ""

    var body: some View {
        NavigationView {
            Form {
                DatePicker("Data badań", selection: $date, displayedComponents: .date)
                TextField("Typ badań", text: $type)
                TextField("Wyniki", text: $results)
                TextField("Notatki lekarza", text: $doctorNotes)
                
                Button("Dodaj wynik") {
                    addMedicalExam()
                }
            }
            .navigationBarTitle("Dodaj Wynik Badań", displayMode: .inline)
            .navigationBarItems(trailing: Button("Zamknij") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }

    private func addMedicalExam() {
        let newExam = MedicalExam(
            id: "",
            patientID: patientID,
            date: date,
            type: type,
            results: results,
            doctorNotes: doctorNotes.isEmpty ? nil : doctorNotes
        )

        Task {
            do {
                let documentID = try await MedicalExamService.shared.createMedicalExam(for: patientID, exam: newExam)
                var updatedExam = newExam
                updatedExam.id = documentID
                try await MedicalExamService.shared.updateMedicalExam(updatedExam)
                presentationMode.wrappedValue.dismiss()
            } catch {
                print("Wystąpił błąd podczas dodawania wyniku badań: \(error)")
            }
        }
    }

}

struct MedicalExamAddView_Previews: PreviewProvider {
    static var previews: some View {
        MedicalExamAddView(patientID: "12345")
    }
}
