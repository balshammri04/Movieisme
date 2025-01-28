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
    @Published var user: User?
    
    private let movieService = MovieService()
    
    init() {
        fetchMovies()
        fetchUser()
    }
    
    func fetchMovies() {
        movieService.fetchMovies { [weak self] movies in
            DispatchQueue.main.async {
                self?.movies = movies
            }
        }
    }
    
    func fetchUser() {
        movieService.fetchUser { [weak self] user in
            DispatchQueue.main.async {
                self?.user = user
            }
        }
    }
}
