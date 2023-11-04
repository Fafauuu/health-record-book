//
//  UserProfileEditView.swift
//  HealthRecordBook
//
//  Created by Rafał Kwiecień on 04/11/2023.
//

import SwiftUI

struct UserEditView: View {
    @Environment(\.presentationMode) var presentationMode
    var userId: String
    
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var dateOfBirth: Date = Date()
    @State private var height: String = ""
    @State private var weight: String = ""
    @State private var bloodType: String = ""
    @State private var allergies: String = ""
    @State private var chronicDiseases: String = ""
    
    private var isFormValid: Bool {
        !(firstName.isEmpty || lastName.isEmpty || height.isEmpty || weight.isEmpty || bloodType.isEmpty)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Dane osobowe")) {
                    TextField("Imię", text: $firstName)
                    TextField("Nazwisko", text: $lastName)
                    DatePicker("Data urodzenia", selection: $dateOfBirth, displayedComponents: .date)
                }
                
                Section(header: Text("Dane medyczne")) {
                    TextField("Wzrost (cm)", text: $height)
                        .keyboardType(.decimalPad)
                    TextField("Waga (kg)", text: $weight)
                        .keyboardType(.decimalPad)
                    TextField("Grupa krwi", text: $bloodType)
                    TextField("Alergie", text: $allergies)
                    TextField("Choroby przewlekłe", text: $chronicDiseases)
                }
                
                Button("Zapisz zmiany") {
                    saveChanges()
                    presentationMode.wrappedValue.dismiss()
                }
                .disabled(!isFormValid)
            }
            .navigationBarTitle("Edycja profilu", displayMode: .inline)
            .navigationBarItems(trailing: Button("Zamknij") {
                presentationMode.wrappedValue.dismiss()
            })
            .onAppear {
                // Ładowanie danych użytkownika przy otwarciu widoku
                loadUserData()
            }
        }
    }
    
    private func loadUserData() {
        Task {
            do {
                let userDTO = try await UserManager.shared.getUser(userId: userId)
                firstName = userDTO.firstName
                lastName = userDTO.lastName
                dateOfBirth = userDTO.dateOfBirth
                height = String(format: "%.2f", userDTO.height)
                weight = String(format: "%.2f", userDTO.weight)
                bloodType = userDTO.bloodType
                allergies = userDTO.allergies?.joined(separator: ", ") ?? ""
                chronicDiseases = userDTO.chronicDiseases?.joined(separator: ", ") ?? ""
            } catch {
                print("Error loading user data: \(error)")
            }
        }
    }
    
    private func saveChanges() {
//         Logika zapisu zmian w profilu użytkownika
//         Może to być wywołanie funkcji aktualizującej dokument w Firestore
//         Przykład:
//         UserManager.shared.updateUser(with: userDTO)
    }
}

struct UserEditView_Previews: PreviewProvider {
    static var previews: some View {
        UserEditView(userId: "12345")
    }
}
