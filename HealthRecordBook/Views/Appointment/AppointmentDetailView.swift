//
//  AppointmentDetailView.swift
//  HealthRecordBook
//
//  Created by Rafał Kwiecień on 13/11/2023.
//

import SwiftUI

struct AppointmentDetailView: View {
    let appointment: Appointment
    
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
                    Text("Typ wizyty: \(appointment.type)")
                    Text("Data: \(appointment.date, formatter: dateFormatter)")
                    Text("Miejsce: \(appointment.location)")
                    Text("Lekarz: \(appointment.specialist)")
                }.font(.title2)
            }
            .padding()
        }
        .navigationTitle("Szczegóły Wizyty")
    }
}
