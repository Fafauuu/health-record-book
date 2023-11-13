//
//  MedicalVisitListView.swift
//  HealthRecordBook
//
//  Created by Rafał Kwiecień on 13/11/2023.
//

import SwiftUI

struct ExaminationListView: View {
    @StateObject private var viewModel = ExaminationViewModel()
    @State private var isAddViewPresented = false

    var body: some View {
        NavigationView {
            List(viewModel.examinations) { examination in
                NavigationLink(destination: ExaminationDetailView(examination: examination)) {
                    ExaminationTileView(examination: examination)
                }
            }
            .navigationTitle("Wyniki badań")
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
                    ExaminationAddView(patientID: patientID)
                }
            }
            .onAppear {
                Task {
                    await viewModel.fetchExaminations()
                }
            }
        }
    }
    
    private func loadData() {
        Task {
             await viewModel.fetchExaminations()
        }
    }
}

struct ExaminationListView_Previews: PreviewProvider {
    static var previews: some View {
        ExaminationListView()
    }
}

