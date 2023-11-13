//
//  AppointmentsViewModel.swift
//  HealthRecordBook
//
//  Created by Rafał Kwiecień on 13/11/2023.
//

import Foundation

class AppointmentViewModel: ObservableObject {
    @Published var appointments: [Appointment] = []
    
    func fetchAppointments() async {
        guard let patientID = SessionManager.shared.getUserId() else { return }
        do {
            let fetchedAppointments = try await AppointmentService.shared.getAppointments(for: patientID)
            DispatchQueue.main.async {
                self.appointments = fetchedAppointments
            }
        } catch {
            print("Error fetching appointments: \(error)")
        }
    }
    
    func fetchPastAppointments() async {
        guard let patientID = SessionManager.shared.getUserId() else { return }
        do {
            let pastAppointments = try await AppointmentService.shared.getPastAppointments(for: patientID)
            DispatchQueue.main.async {
                self.appointments = pastAppointments
            }
        } catch {
            print("Error fetching past appointments: \(error)")
        }
    }
}
