//
//  MovieService.swift
//  Movieisme
//
//  Created by bayan alshammri on 28/01/2025.
//



import Foundation

class MovieService {
    /// Fetch movies from JSON data
    func fetchMovies(from jsonData: Data) -> [Movie] {
        do {
            let movieResponse = try JSONDecoder().decode(MovieResponse.self, from: jsonData)
            return movieResponse.records.map { record in
                Movie(
                    id: record.id,
                    name: record.fields.name,
                    rating: record.fields.rating,
                    genre: record.fields.genre,
                    poster: record.fields.poster,
                    language: record.fields.language,
                    IMDb_rating: record.fields.IMDb_rating,
                    runtime: record.fields.runtime,
                    story: record.fields.story
                )
            }
        } catch {
            print("Failed to decode JSON: \(error)")
            return []
        }
    }

    /// Fetch a user from the API
    func fetchUser(completion: @escaping (User?) -> Void) {
        guard let url = URL(string: "https://yourapi.com/get-users") else {
            print("Invalid URL")
            completion(nil)
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("Error fetching user: \(error)")
                completion(nil)
                return
            }

            if let data = data {
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(UserResponse.self, from: data)
                    if let userRecord = response.records.first {
                        let user = User(
                            id: userRecord.id,
                            email: userRecord.fields.email,
                            password: userRecord.fields.password,
                            profileImage: userRecord.fields.profile_image,
                            name: userRecord.fields.name
                        )
                        completion(user)
                    } else {
                        completion(nil)
                    }
                } catch {
                    print("Error decoding user: \(error)")
                    completion(nil)
                }
            }
        }.resume()
    }
}

