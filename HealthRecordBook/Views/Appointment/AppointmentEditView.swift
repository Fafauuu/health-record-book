//
//  AppointmentEditView.swift
//  HealthRecordBook
//
//  Created by Rafał Kwiecień on 02/12/2023.
//

import SwiftUI

struct AppointmentEditView: View {
    @Environment(\.presentationMode) var presentationMode
    var appointmentId: String
    @State private var appointment: Appointment?

    var body: some View {
        NavigationView {
            Form {
                if let appointmentBinding = Binding($appointment) {
                    DatePicker("Data wizyty", selection: appointmentBinding.date, displayedComponents: .date)
                    TextField("Typ wizyty", text: appointmentBinding.type)
                    TextField("Miejsce", text: appointmentBinding.location)
                    TextField("Lekarz", text: appointmentBinding.specialist)

                    Button("Zapisz zmiany") {
                        updateAppointment()
                    }
                } else {
                    Text("Ładowanie...")
                        .onAppear {
                            loadAppointmentData()
                        }
                }
            }
            .navigationBarTitle("Edytuj Wizytę", displayMode: .inline)
            .navigationBarItems(trailing: Button("Zamknij") {
                presentationMode.wrappedValue.dismiss()
            })
            .onAppear {
                loadAppointmentData()
            }
        }
    }

    private func loadAppointmentData() {
        Task {
            do {
                self.appointment = try await AppointmentService.shared.getAppointment(appointmentId: appointmentId)
            } catch {
                print("Error loading appointment data: \(error)")
            }
        }
    }

    private func updateAppointment() {
        guard let appointment = appointment else { return }
        Task {
            do {
                try await AppointmentService.shared.updateAppointment(appointment)
                presentationMode.wrappedValue.dismiss()
            } catch {
                print("Error updating appointment: \(error)")
            }
        }
    }
}

