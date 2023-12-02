//
//  AppointmentDetailView.swift
//  HealthRecordBook
//
//  Created by Rafał Kwiecień on 13/11/2023.
//

import SwiftUI

struct AppointmentDetailView: View {
    let appointment: Appointment
    var isHistoryView: Bool
    @State private var isEditViewPresented = false
    @Environment(\.presentationMode) var presentationMode // For dismissing the view

    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter
    }

    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    Group {
                        Text("Typ wizyty: \(appointment.type)")
                        Text("Data: \(appointment.date, formatter: dateFormatter)")
                        Text("Miejsce: \(appointment.location)")
                        Text("Lekarz: \(appointment.specialist)")
                    }.font(.title2)
                }
                .padding()
            }

            if !isHistoryView {
                Button("Edytuj") {
                    isEditViewPresented = true
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                .padding(.horizontal)
                
                Button("Usuń wizytę") {
                    Task {
                        await deleteAppointment()
                    }
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(10)
                .padding(.horizontal)
            }
            Spacer()
        }
        .navigationTitle("Szczegóły Wizyty")
        .sheet(isPresented: $isEditViewPresented) {
            AppointmentEditView(appointmentId: appointment.id)
        }
    }

    private func deleteAppointment() async {
        do {
            try await AppointmentService.shared.deleteAppointment(appointment)
            DispatchQueue.main.async {
                self.presentationMode.wrappedValue.dismiss()
            }
        } catch {
            print("Error deleting appointment: \(error)")
        }
    }
}

