//
//  MedicalExamListView.swift
//  HealthRecordBook
//
//  Created by Rafał Kwiecień on 04/11/2023.
//

import SwiftUI

struct MedicalExamListView: View {
    @StateObject private var viewModel = MedicalExamViewModel()
    @State private var isAddViewPresented = false

    var body: some View {
        NavigationView {
            List(viewModel.medicalExams) { exam in
                NavigationLink(destination: MedicalExamDetailView(exam: exam)) {
                    MedicalExamTileView(exam: exam)
                }
            }
            .navigationTitle("Wyniki Badań")
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
                if let patientID = SessionManager.shared.userId {
                    MedicalExamAddView(patientID: patientID)
                }
            }
            .onAppear {
                Task {
                    await viewModel.fetchMedicalExams()
                }
            }
        }
    }
    
    private func loadData() {
        Task {
            do {
                await viewModel.fetchMedicalExams()
            }
        }
    }
}

struct MedicalExamListView_Previews: PreviewProvider {
    static var previews: some View {
        MedicalExamListView()
    }
}

