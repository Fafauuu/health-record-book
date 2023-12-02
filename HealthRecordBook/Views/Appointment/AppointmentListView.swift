//
//  AppointmentListView.swift
//  HealthRecordBook
//
//  Created by Rafał Kwiecień on 13/11/2023.
//

import SwiftUI

struct AppointmentListView: View {
    @StateObject private var viewModel = AppointmentViewModel()
    @State private var isAddViewPresented = false
    var isHistoryView: Bool = false

    var body: some View {
        NavigationView {
            List(viewModel.appointments) { appointment in
                NavigationLink(destination: AppointmentDetailView(appointment: appointment, isHistoryView: isHistoryView)) {
                    AppointmentTileView(appointment: appointment)
                }
            }
            .navigationTitle(isHistoryView ? "Historia wizyt" : "Terminarz")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    if !isHistoryView {
                        Button(action: {
                            isAddViewPresented = true
                        }) {
                            Image(systemName: "plus")
                        }
                    }
                }
            }
            .sheet(isPresented: $isAddViewPresented, onDismiss: loadData) {
                if let patientID = SessionManager.shared.getUserId() {
                    AppointmentAddView(patientID: patientID)
                }
            }
            .onAppear {
                Task {
                    await (isHistoryView ? viewModel.fetchPastAppointments() : viewModel.fetchAppointments())
                }
            }
        }
    }
    
    private func loadData() {
        Task {
            await viewModel.fetchAppointments()
        }
    }
}
