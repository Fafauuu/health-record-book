//
//  VaccinationAddView.swift
//  HealthRecordBook
//
//  Created by Rafał Kwiecień on 04/11/2023.
//

import SwiftUI

struct VaccinationAddView: View {
    @Environment(\.presentationMode) var presentationMode
    var patientID: String

    @State private var date = Date()
    @State private var type = ""
    @State private var sideEffects = ""

    var body: some View {
        NavigationView {
            Form {
                DatePicker("Data szczepienia", selection: $date, displayedComponents: .date)
                TextField("Typ szczepienia", text: $type)
                TextField("Skutki uboczne", text: $sideEffects)

                Button("Dodaj szczepienie") {
                    addVaccination()
                }
            }
            .navigationBarTitle("Dodaj Szczepienie", displayMode: .inline)
            .navigationBarItems(trailing: Button("Zamknij") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }

    private func addVaccination() {
        let newVaccination = Vaccination(
            id: "",
            patientID: patientID,
            date: date,
            type: type,
            sideEffects: sideEffects.isEmpty ? nil : sideEffects
        )

        Task {
            do {
                let documentID = try await VaccinationService.shared.createVaccination(for: patientID, vaccination: newVaccination)
                var updatedVaccination = newVaccination
                updatedVaccination.id = documentID
                try await VaccinationService.shared.updateVaccination(updatedVaccination)
                presentationMode.wrappedValue.dismiss()
            } catch {
                print("Error adding vaccination: \(error)")
            }
        }
    }
}
