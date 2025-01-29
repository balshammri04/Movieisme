//
//  MovieService.swift
//  Movieisme
//
//  Created by bayan alshammri on 28/01/2025.
//

import Foundation



class MovieService {
    func fetchMovies(completion: @escaping ([Movie]) -> Void) {
        guard let url = URL(string: "pat174iMzI1IjVaWW.ee3816d9d6dad6782fb6e502392173de3ed73a05546fe5a1068dfaab9056f997") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let movieResponse = try JSONDecoder().decode(MovieResponse.self, from: data)
                    let movies = movieResponse.records.map { record in
                        Movie(
                    id: record.id,
                    name: record.fields.name,
                    poster: record.fields.poster,      // ✅ تأكد أن الترتيب متطابق
                    genre: record.fields.genre,
                    IMDb_rating: record.fields.IMDb_rating,
                    runtime: record.fields.runtime,
                    rating: record.fields.rating,      // ✅ التأكد من أن الترتيب متوافق
                    language: record.fields.language,
                    story: record.fields.story
                        )
                                            }
                                            DispatchQueue.main.async {
                                                completion(movies)
                                            }
                                        } catch {
                                            print("Error decoding movies: \(error)")
                                        }
                                    }
                                }.resume()
                            }

                            // ✅ **إضافة الدالة الجديدة لاسترجاع فيلم حسب ID**
                            func fetchMovieById(movieId: String, completion: @escaping (Movie?) -> Void) {
                                guard let url = URL(string: "pat174iMzI1IjVaWW.ee3816d9d6dad6782fb6e502392173de3ed73a05546fe5a1068dfaab9056f997") else { return }

                                URLSession.shared.dataTask(with: url) { data, response, error in
                                    if let data = data {
                                        do {
                                            let movieResponse = try JSONDecoder().decode(MovieResponse.self, from: data)
                                            if let movieRecord = movieResponse.records.first {
                                                let movie = Movie(
              id: movieRecord.id,
              name: movieRecord.fields.name,
              poster: movieRecord.fields.poster,
              genre: movieRecord.fields.genre,
              IMDb_rating: movieRecord.fields.IMDb_rating,
              runtime: movieRecord.fields.runtime,
             rating: movieRecord.fields.rating,
               language: movieRecord.fields.language,
              story: movieRecord.fields.story
                                                )
                                                DispatchQueue.main.async {
                                                    completion(movie)
                                                }
                                            } else {
                                                completion(nil)
                                            }
                                        } catch {
                                            print("Error decoding movie: \(error)")
                                            completion(nil)
                                        }
                                    }
                                }.resume()
                            }
                        }




func getMovies() -> [Movie] {
    return [
        Movie(id: "1",
              name: "The Dark Knight",
              poster: "https://i.pinimg.com/736x/88/c8/20/88c8204e1017437290af9db9a02d83f6.jpg",
              genre: ["Drama", "Action"],
              IMDb_rating: 9.0,
              runtime: "2h 32m",
              rating: "PG-13",
              language: ["English"],
              story: "Set within a year after the events of Batman Begins (2005), Batman, Lieutenant James Gordon, and new District Attorney Harvey Dent begin to round up Gotham's criminals, until a sadistic criminal mastermind known as The Joker appears."
        ),
        
        Movie(id: "2",
              name: "The Shawshank Redemption",
              poster: "https://i.imghippo.com/files/mHB5371A.jpg",
              genre: ["Drama"],
              IMDb_rating: 9.3,
              runtime: "2h 22m",
              rating: "R",
              language: ["English"],
              story: "Chronicles the experiences of a formerly successful banker as a prisoner in the gloomy jailhouse of Shawshank after being found guilty of a crime he did not commit."
        ),
        
        Movie(id: "3",
              name: "Top Gun",
              poster: "https://i.pinimg.com/736x/0e/e3/41/0ee34190d837ddf0048c2caf14a2ff8e.jpg",
              genre: ["Action", "Drama"],
              IMDb_rating: 9.6,
              runtime: "2h 9m",
              rating: "R",
              language: ["English"],
              story: "Pete 'Maverick' Mitchell is a hotshot Navy pilot whose skill is as legendary as his reckless streak. Sent to the elite TOPGUN program with his partner, 'Goose'."
        )
    ]
}
