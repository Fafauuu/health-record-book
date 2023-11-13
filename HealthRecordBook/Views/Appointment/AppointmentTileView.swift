//
//  AppointmentTileView.swift
//  HealthRecordBook
//
//  Created by Rafał Kwiecień on 13/11/2023.
//

import SwiftUI

struct AppointmentTileView: View {
    let appointment: Appointment
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(appointment.type)
                .font(.headline)
            Text(appointment.date, style: .date)
                .font(.subheadline)
        }
    }
}
