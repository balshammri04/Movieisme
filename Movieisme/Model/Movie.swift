//
//  Movie.swift
//  Movieisme
//
//  Created by bayan alshammri on 28/01/2025.
//

import Foundation

// Decodable structure for Movie API response
struct MovieResponse: Decodable {
    let records: [MovieRecord]
}

struct MovieRecord: Decodable {
    let id: String
    let fields: MovieFields
}

struct MovieFields: Decodable {
    let name: String
    let rating: String
    let genre: [String]
    let poster: String
    let language: [String]
    let IMDb_rating: Double
    let runtime: String
    let story: String
}

/// Decodable structure for User API response
struct UserResponse: Decodable {
    let records: [UserRecord]
}

struct UserRecord: Decodable {
    let id: String
    let fields: UserFields
}

struct UserFields: Decodable {
    let email: String
    let password: String
    let profile_image: String
    let name: String
}

// MARK: - User and Movie Models for App Usage

/// Movie model
struct Movie: Identifiable {
    let id: String
    let name: String
    let rating: String
    let genre: [String]
    let poster: String
    let language: [String]
    let IMDb_rating: Double
    let runtime: String
    let story: String
}
