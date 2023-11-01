//
//  LoginView.swift
//  HealthRecordBook
//
//  Created by Rafał Kwiecień on 01/11/2023.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var homeViewModel: HomeViewModel
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Email", text: $email)
                        .accessibility(identifier: "emailField")
                    SecureField("Hasło", text: $password)
                        .accessibility(identifier: "passwordField")
                }
                Button("Zaloguj") {
                    homeViewModel.login(email: email, password: password)
                }
                .accessibility(identifier: "loginButton")
            }
            .navigationBarTitle("Logowanie", displayMode: .inline)
            .navigationBarItems(leading: Button("Zamknij") { presentationMode.wrappedValue.dismiss() })
            .onChange(of: homeViewModel.isLogged) { isLogged in
                if isLogged {
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }
    }
}
