//
//  ContentView.swift
//  Movieisme
//
//  Created by bayan alshammri on 20/01/2025.
//

import SwiftUI
import Foundation


@main
struct MovieismeApp: App {
    var body: some Scene {
        WindowGroup {
            SignInView() // الشاشة الرئيسية للتطبيق
        }
    }
}


struct Movie {
    var title: String
    var duration: String
    var language: String
    var genre: String
    var ageRating: String
    var story: String
    var imdbRating: Double
    var director: String
    var stars: [String]
    var reviews: [Review]

    // بيانات تجريبية
    static let placeholder = Movie(title: "Loading...",
                                   duration: "",
                                   language: "",
                                   genre: "",
                                   ageRating: "",
                                   story: "",
                                   imdbRating: 0.0,
                                   director: "",
                                   stars: [],
                                   reviews: [])

    static let example = Movie(title: "Shawshank",
                                duration: "2 hours 22 mins",
                                language: "English",
                                genre: "Drama",
                                ageRating: "15",
                                story: "Synopsis of Shawshank...",
                                imdbRating: 9.3,
                                director: "Frank Darabont",
                                stars: ["Tim Robbins", "Morgan Freeman", "Bob Gunton"],
                                reviews: [
                                    Review(id: 1, username: "Afnan", rating: 4.8, comment: "Amazing movie!")
                                ])
}

struct Review: Identifiable {
    var id: Int
    var username: String
    var rating: Double
    var comment: String
}


struct AirtableUser: Codable {
    let id: String
    let fields: Fields

    struct Fields: Codable {
        let name: String
        let email: String
    }
}

struct User: Codable {
    let id: String
    let email: String
    let password: String
    let name: String
}
