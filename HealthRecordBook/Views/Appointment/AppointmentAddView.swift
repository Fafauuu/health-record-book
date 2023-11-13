//
//  AppointmentAddView.swift
//  HealthRecordBook
//
//  Created by Rafał Kwiecień on 13/11/2023.
//

import SwiftUI

struct AppointmentAddView: View {
    @Environment(\.presentationMode) var presentationMode
    var patientID: String

    @State private var date = Date()
    @State private var type = ""
    @State private var location = ""
    @State private var specialist = ""

    var body: some View {
        NavigationView {
            Form {
                DatePicker("Data wizyty", selection: $date, displayedComponents: .date)
                TextField("Typ wizyty", text: $type)
                TextField("Miejsce", text: $location)
                TextField("Lekarz", text: $specialist)

                Button("Dodaj wizytę") {
                    addAppointment()
                }
            }
            .navigationBarTitle("Dodaj Wizytę", displayMode: .inline)
            .navigationBarItems(trailing: Button("Zamknij") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }

    private func addAppointment() {
        let newAppointment = Appointment(
            id: "",
            patientID: patientID,
            date: date,
            type: type,
            location: location,
            specialist: specialist
        )

        Task {
            do {
                let documentID = try await AppointmentService.shared.createAppointment(for: patientID, appointment: newAppointment)
                var updatedAppointment = newAppointment
                updatedAppointment.id = documentID
                try await AppointmentService.shared.updateAppointment(updatedAppointment)
                presentationMode.wrappedValue.dismiss()
            } catch {
                print("Error adding appointment: \(error)")
            }
        }
    }
}
