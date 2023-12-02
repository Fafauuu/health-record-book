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
    @Environment(\.presentationMode) var presentationMode

    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter
    }

    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 15) {
                    GroupBox(label: Text("Typ wizyty").fontWeight(.bold)) {
                        VStack(alignment: .leading, spacing: 5) {
                            Text(appointment.type)
                                .font(.body)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }

                    GroupBox(label: Text("Data").fontWeight(.bold)) {
                        VStack(alignment: .leading, spacing: 5) {
                            Text(appointment.date, formatter: dateFormatter)
                                .font(.body)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }

                    GroupBox(label: Text("Miejsce").fontWeight(.bold)) {
                        VStack(alignment: .leading, spacing: 5) {
                            Text(appointment.location)
                                .font(.body)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }

                    GroupBox(label: Text("Lekarz").fontWeight(.bold)) {
                        VStack(alignment: .leading, spacing: 5) {
                            Text(appointment.specialist)
                                .font(.body)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
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
