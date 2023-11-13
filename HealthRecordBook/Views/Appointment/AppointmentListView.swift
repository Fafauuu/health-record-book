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
    var isHistoryView: Bool = false // Dodano flagę

    var body: some View {
        NavigationView {
            List(viewModel.appointments) { appointment in
                NavigationLink(destination: AppointmentDetailView(appointment: appointment)) {
                    AppointmentTileView(appointment: appointment)
                }
            }
            .navigationTitle(isHistoryView ? "Historia wizyt" : "Terminarz") // Tytuł zmienia się w zależności od flagi
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    if !isHistoryView { // Pokaż przycisk tylko, gdy nie jesteśmy w widoku historii
                        Button(action: {
                            isAddViewPresented = true
                        }) {
                            Image(systemName: "plus")
                        }
                    }
                }
            }
            .sheet(isPresented: $isAddViewPresented) {
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
}
