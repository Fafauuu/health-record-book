//
//  MedicalExamListView.swift
//  HealthRecordBook
//
//  Created by Rafał Kwiecień on 04/11/2023.
//


import SwiftUI

struct VaccinationListView: View {
    @StateObject private var viewModel = VaccinationViewModel()
    @State private var isAddViewPresented = false

    var body: some View {
        NavigationView {
            List(viewModel.vaccinations) { vaccination in
                NavigationLink(destination: VaccinationDetailView(vaccination: vaccination)) {
                    VaccinationTileView(vaccination: vaccination)
                }
            }
            .navigationTitle("Szczepienia")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isAddViewPresented = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $isAddViewPresented, onDismiss: loadData) {
                if let patientID = SessionManager.shared.getUserId() {
                    VaccinationAddView(patientID: patientID)
                }
            }
            .onAppear {
                Task {
                    await viewModel.fetchVaccinations()
                }
            }
        }
    }
    
    private func loadData() {
        Task {
            await viewModel.fetchVaccinations()
        }
    }
}
