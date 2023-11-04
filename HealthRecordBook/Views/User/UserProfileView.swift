//
//  UserProfileView.swift
//  HealthRecordBook
//
//  Created by Rafał Kwiecień on 01/11/2023.
//

import SwiftUI

struct UserProfileView: View {
    @StateObject var viewModel = UserProfileViewModel()
    @State private var isEditViewPresented = false

    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        formatter.locale = Locale(identifier: "pl_PL")
        return formatter
    }()

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                if let user = viewModel.user {
                    GroupBox(label: Label("Informacje osobiste", systemImage: "person.fill")) {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Imię: \(user.firstName)")
                            Text("Nazwisko: \(user.lastName)")
                            Text("Data urodzenia: \(dateFormatter.string(from: user.dateOfBirth))")
                            Text("Wzrost: \(user.height, specifier: "%.2f") cm")
                            Text("Waga: \(user.weight, specifier: "%.2f") kg")
                            Text("Grupa krwi: \(user.bloodType)")

                            if let allergies = user.allergies, !allergies.isEmpty {
                                Text("Alergie: \(allergies.joined(separator: ", "))")
                            }

                            if let diseases = user.chronicDiseases, !diseases.isEmpty {
                                Text("Choroby przewlekłe: \(diseases.joined(separator: ", "))")
                            }
                        }
                        .padding(4)
                    }
                    .groupBoxStyle(DefaultGroupBoxStyle())
                    .padding()

                    Button("Edycja danych") {
                        isEditViewPresented = true
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.horizontal)
                    .sheet(isPresented: $isEditViewPresented, onDismiss: loadUserData) {
                        UserEditView(userId: user.id)
                    }
                } else {
                    Text("Ładowanie informacji o użytkowniku...")
                        .foregroundColor(.gray)
                }
            }
        }
        .navigationTitle("Profil")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            do {
                try await viewModel.loadCurrentUser()
            } catch {
                print(error)
            }
        }
    }
    
    private func loadUserData() {
        Task {
            do {
                try await viewModel.loadCurrentUser()
            } catch {
                print("Error loading user data: \(error)")
            }
        }
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView()
    }
}

