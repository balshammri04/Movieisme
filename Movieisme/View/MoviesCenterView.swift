
import SwiftUI

struct MoviesCenterView: View {
    let user: User // المستخدم الذي قام بتسجيل الدخول
    
    @State private var highRatedMovies: [Movie] = []
    @State private var movieCategories: [String: [Movie]] = [:]
    @State private var searchQuery: String = ""
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    // Header with user profile image
                    HStack {
                        Text("Movies Center")
                            .font(.largeTitle)
                            .bold()
                        Spacer()
                        if let url = URL(string: user.profileImage) {
                            AsyncImage(url: url) { image in
                                image.resizable()
                                    .scaledToFill()
                                    .frame(width: 40, height: 40)
                                    .clipShape(Circle())
                            } placeholder: {
                                ProgressView()
                            }
                        }
                    }
                    .padding(.horizontal)
                    
                    // Search Bar
                    TextField("Search for Movie name, actors ...", text: $searchQuery)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .padding(.horizontal)
                    
                    // High Rated Movies Carousel
                    VStack(alignment: .leading) {
                        Text("High Rated")
                            .font(.headline)
                        TabView {
                                                    ForEach(highRatedMovies, id: \.id) { movie in
                                                        VStack {
                                                            if let url = URL(string: movie.poster) {
                                                                AsyncImage(url: url) { image in
                                                                    image.resizable()
                                                                        .scaledToFit()
                                                                        .frame(width: 300, height: 400)
                                                                        .cornerRadius(15)
                                                                } placeholder: {
                                                                    ProgressView()
                                                                }
                                                            }

                                                            VStack(alignment: .leading, spacing: 5) {
                                                                Text(movie.name)
                                                                    .font(.headline)
                                                                
                                                                Text("\(movie.IMDb_rating, specifier: "%.1f") / 10 • \(movie.genre.joined(separator: ", ")) • \(movie.runtime)")
                                                                    .font(.subheadline)
                                                                    .foregroundColor(.gray)
                                                            }
                                                            .padding(.horizontal)
                                                        }
                                                    }
                                                }
                                                .frame(height: 450)
                                                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                                            }
                                            
                                            // 🔹 عرض الأفلام حسب الفئات (Drama - Comedy)
                                            ForEach(movieCategories.keys.sorted(), id: \.self) { category in
                                                MovieCategoryView(categoryName: category, movies: movieCategories[category] ?? [])
                                            }
                                        }
                                    }
                                    .navigationBarBackButtonHidden(true) // 🔹 منع المستخدم من الرجوع
                                    .onAppear {
                                        fetchMovies()
                                    }
                                }
                            }

    private func fetchMovies() {
            let movies = getMovies()
            highRatedMovies = movies.sorted { $0.IMDb_rating > $1.IMDb_rating }.prefix(5).map { $0 }
            movieCategories = Dictionary(grouping: movies, by: { $0.genre.first ?? "Other" })
        }
    }


// Movie Card View
struct MovieCard: View {
    let movie: Movie

    var body: some View {
        VStack {
            if let url = URL(string: movie.poster) {
                AsyncImage(url: url) { image in
                    image.resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 300)
                        .cornerRadius(12)
                } placeholder: {
                    ProgressView()
                }
            }

            VStack(alignment: .leading, spacing: 5) {
                Text(movie.rating)
                    .font(.caption)
                    .foregroundColor(.gray)

                Text("\(movie.IMDb_rating, specifier: "%.1f") / 10")
                    .font(.headline)

                Text(movie.genre.joined(separator: ", "))
                    .font(.caption)
                    .foregroundColor(.gray)

                Text(movie.runtime)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .padding(.top, 5)
        }
        .frame(width: 200)
    }
}

// Movie Category View
struct MovieCategoryView: View {
    let categoryName: String
    let movies: [Movie]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(categoryName)
                    .font(.headline)
                    .bold()
                Spacer()
                Button(action: {}) {
                    Text("Show more")
                        .font(.caption)
                        .foregroundColor(.yellow)
                }
            }
            .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(movies, id: \ .id) { movie in
                        MoviePosterView(movie: movie)
                    }
                }
                .padding(.horizontal)
            }
        }
        .padding(.vertical)
    }
}

// Movie Poster View
struct MoviePosterView: View {
    let movie: Movie
    
    var body: some View {
        if let url = URL(string: movie.poster) {
            AsyncImage(url: url) { image in
                image.resizable()
                    .scaledToFill()
                    .frame(width: 150, height: 220)
                    .cornerRadius(12)
            } placeholder: {
                ProgressView()
            }
        }
    }
}




struct MoviesCenterView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesCenterView(user: User.defaultUser)
    }
}
