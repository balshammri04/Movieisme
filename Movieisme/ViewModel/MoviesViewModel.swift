//
//  MoviesViewModel.swift
//  Movieisme
//
//  Created by bayan alshammri on 28/01/2025.
//

import Foundation
import Combine

class MoviesViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    @Published var highRatedMovies: [Movie] = []
    @Published var movieCategories: [String: [Movie]] = [:]
    
    private let movieService = MovieService()
    
    init() {
        fetchMovies()
    }
    
    /// جلب الأفلام من API وتحديث البيانات
    func fetchMovies() {
        movieService.fetchMovies { [weak self] movies in
            DispatchQueue.main.async {
                self?.movies = movies
                
                // ترتيب أعلى الأفلام تقييمًا
                self?.highRatedMovies = movies.sorted { $0.IMDb_rating > $1.IMDb_rating }.prefix(5).map { $0 }
                
                // تصنيف الأفلام بناءً على النوع (Genre)
                self?.movieCategories = Dictionary(grouping: movies, by: { $0.genre.first ?? "Other" })
            }
        }
    }
    
    /// جلب فيلم معين بناءً على الـ ID
    func fetchMovieById(movieId: String, completion: @escaping (Movie?) -> Void) {
        movieService.fetchMovieById(movieId: movieId) { movie in
            DispatchQueue.main.async {
                completion(movie)
            }
        }
    }
}
