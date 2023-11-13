//
//  MedicalVisitViewModel.swift
//  HealthRecordBook
//
//  Created by Rafał Kwiecień on 13/11/2023.
//

import Foundation

class ExaminationViewModel: ObservableObject {
    @Published var examinations: [Examination] = []
    
    func fetchExaminations() async {
        guard let patientID = SessionManager.shared.getUserId() else { return }

        do {
            let examinations = try await ExaminationService.shared.getExaminations(for: patientID)
            DispatchQueue.main.async {
                self.examinations = examinations
            }
        } catch {
            print("Error fetching examinations: \(error)")
        }
    }
}
