//
//  UserModels.swift
//  Movieisme
//
//  Created by bayan alshammri on 28/01/2025.
//




import Foundation

struct User: Identifiable {
    let id: String
    let email: String
    let password: String
    let profileImage: String
    let name: String
}

extension User {
    static let defaultUser = User(id: "", email: "", password: "", profileImage: "", name: "Guest")
}
