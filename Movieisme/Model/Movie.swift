//
//  Movie.swift
//  Movieisme
//
//  Created by bayan alshammri on 28/01/2025.
//

import Foundation

import Foundation

struct Movie: Identifiable, Codable {
    let id: String
    let name: String
    let poster: String
    let genre: [String]
    let IMDb_rating: Double
    let runtime: String
    let rating: String    // ✅ ترتيب صحيح
    let language: [String]
    let story: String
}



struct MovieResponse: Codable {
    let records: [MovieRecord]
}

struct MovieRecord: Codable {
    let id: String
    let fields: MovieFields
}

struct MovieFields: Codable {
    let name: String
    let rating: String
    let genre: [String]
    let poster: String
    let language: [String]
    let IMDb_rating: Double
    let runtime: String
    let story: String
}
