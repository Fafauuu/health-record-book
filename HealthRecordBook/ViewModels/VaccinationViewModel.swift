//
//  MedicalExamViewModel.swift
//  HealthRecordBook
//
//  Created by Rafał Kwiecień on 04/11/2023.
//

import Foundation

class VaccinationViewModel: ObservableObject {
    @Published var vaccinations: [Vaccination] = []
    
    func fetchVaccinations() async {
        guard let patientID = SessionManager.shared.getUserId() else { return }
        do {
            let fetchedVaccinations = try await VaccinationService.shared.getVaccinations(for: patientID)
            DispatchQueue.main.async {
                self.vaccinations = fetchedVaccinations
            }
        } catch {
            print("Error fetching vaccinations: \(error)")
        }
    }
}
