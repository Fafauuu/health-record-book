//
//  RegistrationView.swift
//  HealthRecordBook
//
//  Created by Rafał Kwiecień on 01/11/2023.
//

import SwiftUI

struct RegistrationView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var name = ""
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var homeViewModel: HomeViewModel
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Email", text: $email)
                    SecureField("Hasło", text: $password)
                    SecureField("Powtórz hasło", text: $confirmPassword)
                }
                Button("Zarejestruj") {
                    if password == confirmPassword {
                        Task {
                            do {
                                try await homeViewModel.register(email: email, password: password)
                                print("Success")
                                presentationMode.wrappedValue.dismiss()
                            } catch {
                                print("Error: \(error)")
                            }
                        }
                    }
                }
            }
            .navigationBarTitle("Rejestracja", displayMode: .inline)
            .navigationBarItems(leading: Button("Zamknij") { presentationMode.wrappedValue.dismiss() })
        }
    }
}
