//
//  MedicalExamViewModel.swift
//  HealthRecordBook
//
//  Created by Rafał Kwiecień on 04/11/2023.
//

import Foundation

class MedicalExamViewModel: ObservableObject {
    @Published var medicalExams: [MedicalExam] = []

    func fetchMedicalExams() async {
        guard let patientID = SessionManager.shared.getUserId() else { return }

        do {
            let exams = try await MedicalExamService.shared.getMedicalExams(for: patientID)
            DispatchQueue.main.async {
                self.medicalExams = exams
            }
        } catch {
            print("Error fetching medical exams: \(error)")
        }
    }
}
