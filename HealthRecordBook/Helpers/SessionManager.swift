//
//  SessionManager.swift
//  HealthRecordBook
//
//  Created by Rafał Kwiecień on 04/11/2023.
//

import Foundation

class SessionManager {
    static let shared = SessionManager()
    var userId: String?

    private init() {}

    func setUserId(_ userId: String) {
        self.userId = userId
    }

    func getUserId() -> String? {
        return userId
    }
    
    func clearUserId() {
        self.userId = nil
    }
}
