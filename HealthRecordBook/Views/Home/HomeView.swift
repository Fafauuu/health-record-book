//
//  HomeView.swift
//  HealthRecordBook
//
//  Created by Rafał Kwiecień on 01/11/2023.
//

import SwiftUI

struct HomeView: View {
    @StateObject var homeViewModel = HomeViewModel()
    
    @State private var showLoginView = false
    @State private var showRegistrationView = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    Image("logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200, height: 200)
                        .padding()
                    
                    let columns = [
                        GridItem(.flexible(), spacing: 20),
                        GridItem(.flexible(), spacing: 20)
                    ]
                    
                    LazyVGrid(columns: columns, spacing: 20) {
                        HomeScreenButton(destination: TestView(), text: "Mój profil", showLoginView: $showLoginView, homeViewModel: homeViewModel)
                        HomeScreenButton(destination: TestView(), text: "Wyniki badań", showLoginView: $showLoginView, homeViewModel: homeViewModel)
                        HomeScreenButton(destination: TestView(), text: "Nadchodzące wizyty", showLoginView: $showLoginView, homeViewModel: homeViewModel)
                        HomeScreenButton(destination: TestView(), text: "Szczepienia", showLoginView: $showLoginView, homeViewModel: homeViewModel)
                        HomeScreenButton(destination: TestView(), text: "Zalecenia lekarskie", showLoginView: $showLoginView, homeViewModel: homeViewModel)
                        
                    }
                    .padding(40)
                }
            }
            .navigationBarTitle("Ekran główny", displayMode: .inline)
            .navigationBarItems(leading:
                Menu {
                    if homeViewModel.isLogged {
                        Button(action: { homeViewModel.logout() }) {
                            Text("Wyloguj")
                            Image(systemName: "arrowshape.turn.up.backward")
                                .accessibility(identifier: "logoutButton")
                        }
                    } else {
                        Button(action: { showLoginView = true }) {
                            Text("Logowanie")
                            Image(systemName: "person.circle")
                                .accessibility(identifier: "loginButton")
                        }

                        Button(action: { showRegistrationView = true }) {
                            Text("Rejestracja")
                            Image(systemName: "person.badge.plus")
                        }
                    }
                } label: {
                    Image(systemName: "ellipsis")
                        .padding()
                        .accessibilityLabel("Więcej opcji")
                        .accessibility(identifier: "ellipsis")
                }
            )
            .fullScreenCover(isPresented: $showLoginView) {
                LoginView(homeViewModel: homeViewModel)
            }
            .fullScreenCover(isPresented: $showRegistrationView) {
                RegistrationView(homeViewModel: homeViewModel)
            }
            .background(
                Image("bg1")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()
            )
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
