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
                    
                    let columns = [
                        GridItem(.flexible(), spacing: 20),
                        GridItem(.flexible(), spacing: 20)
                    ]
                    
                    LazyVGrid(columns: columns, spacing: 15) {
                        // First row
                        HomeScreenButton(destination: ExaminationListView(), text: "Wyniki badań", showLoginView: $showLoginView, homeViewModel: homeViewModel)
                        Spacer()
                        
                        // Second row
                        Spacer()
                        HomeScreenButton(destination: VaccinationListView(), text: "Szczepienia", showLoginView: $showLoginView, homeViewModel: homeViewModel)
                        
                        // Third row
                        HomeScreenButton(destination: AppointmentListView(isHistoryView: true), text: "Historia wizyt", showLoginView: $showLoginView, homeViewModel: homeViewModel)
                        Spacer()
                        
                        // Fourth row
                        Spacer()
                        HomeScreenButton(destination: AppointmentListView(), text: "Terminarz", showLoginView: $showLoginView, homeViewModel: homeViewModel)
                        
                        // Fifth row
                        HomeScreenButton(destination: UserProfileView(), text: "Mój profil", showLoginView: $showLoginView, homeViewModel: homeViewModel)
                        Spacer()
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
