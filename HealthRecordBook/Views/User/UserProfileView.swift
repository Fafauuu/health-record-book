//
//  UserProfileView.swift
//  HealthRecordBook
//
//  Created by Rafał Kwiecień on 01/11/2023.
//

import SwiftUI

struct UserProfileView: View {
    @StateObject var viewModel = UserProfileViewModel()

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                if let user = viewModel.user {
                    Text("User id: \(user.userId)")
                        .font(.system(size: 26, weight: .semibold))
                        .padding(.horizontal, 40);
                    
                    if let dateCreated = user.dateCreated {
                        Text("Data utworzenia: \(dateCreated)")
                            .font(.title2)
                            .padding(.horizontal, 40)
                            .padding(.vertical, 5)
                    }
                }
//                Text("Opis: \(training.description)")
//                    .font(.title2)
//                    .padding(.horizontal, 40)
//                    .padding(.vertical, 5)

                Spacer()
            }
        }
        .task {try? await viewModel.loadCurrentUser()}
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView()
    }
}
