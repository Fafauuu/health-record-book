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
    @State private var allergiesList: [String] = []
    @State private var chronicDiseasesList: [String] = []
    
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
                
                Section(header: Text("Dane medyczne").font(.headline)) {
                    TextField("Wzrost (cm)", text: $height)
                        .keyboardType(.decimalPad)
                    TextField("Waga (kg)", text: $weight)
                        .keyboardType(.decimalPad)
                    TextField("Grupa krwi", text: $bloodType)
                    
                    GroupBox(label: Text("Alergie").fontWeight(.bold)) {
                        VStack(spacing: 10) {
                            ForEach(allergiesList.indices, id: \.self) { index in
                                TextField("Alergia", text: $allergiesList[index])
                            }
                            .onDelete(perform: deleteAllergy)

                            Button(action: addAllergy) {
                                Text("Dodaj alergię")
                            }
                        }
                        .padding(.top)
                    }
                    .groupBoxStyle(DefaultGroupBoxStyle())
                    
                    GroupBox(label: Text("Choroby przewlekłe").fontWeight(.bold)) {
                        VStack(spacing: 10) {
                            ForEach(chronicDiseasesList.indices, id: \.self) { index in
                                TextField("Choroba przewlekła", text: $chronicDiseasesList[index])
                            }
                            .onDelete(perform: deleteChronicDisease)

                            Button(action: addChronicDisease) {
                                Text("Dodaj chorobę przewlekłą")
                            }
                        }
                        .padding(.top)
                    }
                    .groupBoxStyle(DefaultGroupBoxStyle())
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
                loadUserData()
            }
        }
    }
    
    private func addAllergy() {
        if let last = allergiesList.last, last.isEmpty {
            return
        }
        allergiesList.append("")
    }

    private func deleteAllergy(at offsets: IndexSet) {
        allergiesList.remove(atOffsets: offsets)
    }

    private func addChronicDisease() {
        if let last = chronicDiseasesList.last, last.isEmpty {
            return
        }
        chronicDiseasesList.append("")
    }

    private func deleteChronicDisease(at offsets: IndexSet) {
        chronicDiseasesList.remove(atOffsets: offsets)
    }
    
    private func loadUserData() {
        Task {
            do {
                let userDTO = try await UserService.shared.getUser(userId: userId)
                DispatchQueue.main.async {
                    self.firstName = userDTO.firstName
                    self.lastName = userDTO.lastName
                    self.dateOfBirth = userDTO.dateOfBirth
                    self.height = String(format: "%.2f", userDTO.height)
                    self.weight = String(format: "%.2f", userDTO.weight)
                    self.bloodType = userDTO.bloodType
                    self.allergiesList = userDTO.allergies ?? []
                    self.chronicDiseasesList = userDTO.chronicDiseases ?? []
                }
            } catch {
                print("Error loading user data: \(error)")
            }
        }
    }

    private func saveChanges() {
        let updatedAllergies = allergiesList.filter { !$0.isEmpty }
        let updatedChronicDiseases = chronicDiseasesList.filter { !$0.isEmpty }
        
        let updatedUser = UserDTO(
            id: userId,
            firstName: firstName,
            lastName: lastName,
            dateOfBirth: dateOfBirth,
            height: Double(height) ?? 0,
            weight: Double(weight) ?? 0,
            bloodType: bloodType,
            allergies: updatedAllergies,
            chronicDiseases: updatedChronicDiseases
        )

        Task {
            do {
                try await UserService.shared.updateUser(user: updatedUser)
            } catch {
                print("Wystąpił błąd podczas aktualizacji danych użytkownika: \(error)")
            }
        }
    }
}

struct UserEditView_Previews: PreviewProvider {
    static var previews: some View {
        UserEditView(userId: "12345")
    }
}
