
import SwiftUI
import Foundation

struct MoviesCenterView: View {
    @State private var userImage: String = ""
    @State private var highRatedMovies: [Movie] = []
    @State private var movieCategories: [String: [Movie]] = [:]
    @State private var searchQuery: String = ""
    
    init(userImage: String) {
            _userImage = State(initialValue: userImage)
    
        }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    // Profile Image
                    HStack {
                        if let url = URL(string: userImage) {
                            AsyncImage(url: url) { image in
                                image.resizable()
                                    .scaledToFill()
                                    .frame(width: 40, height: 40)
                                    .clipShape(Circle())
                            } placeholder: {
                                ProgressView()
                            }
                        }
                        Spacer()
                    }
                    .padding([.horizontal, .top])

                    // Search Bar
                    HStack {
                        TextField("Search for Movie name, actors ...", text: $searchQuery)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)

                    // High Rated Movies Section
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
                                    Text(movie.name)
                                        .font(.caption)
                                        .padding(.top, 5)
                                }
                            }
                        }
                        .frame(height: 450)
                        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                    }
                    .padding(.horizontal)

                    // Movie Categories
                    ForEach(movieCategories.keys.sorted(), id: \.self) { category in
                        MovieCategoryView(categoryName: category, movies: movieCategories[category] ?? [])
                    }
                }
            }
            .navigationTitle("Movies Center")
            .onAppear {
                fetchUserProfile()
                fetchMovies()
            }
        }
    }

    private func fetchUserProfile() {
        // Simulate fetching user profile image
        if let user = getUsers().first {
            userImage = user.profileImage
        }
    }

    private func fetchMovies() {
        let movies = getMovies()
        highRatedMovies = movies.sorted { $0.IMDb_rating > $1.IMDb_rating }.prefix(5).map { $0 }

        // Group movies by category
        movieCategories = Dictionary(grouping: movies, by: { $0.genre.first ?? "Other" })
    }

}

struct MovieCategoryView: View {
    let categoryName: String
    let movies: [Movie]

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(categoryName)
                    .font(.headline)

                Spacer()

                Button(action: {
                    // Show more action
                }) {
                    Text("Show more")
                        .font(.caption)
                        .foregroundColor(.yellow)
                }
            }
            .padding(.horizontal)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(movies, id: \.id) { movie in
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
                            Text(movie.name)
                                .font(.caption)
                                .padding(.top, 5)
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
        .padding(.vertical)
    }
}


func getMovies() -> [Movie] {
    return [
        Movie(
            id: "1",
            name: "The Dark Knight",
            rating: "PG-13",
            genre: ["Drama", "Action"],
            poster: "https://i.pinimg.com/736x/88/c8/20/88c8204e1017437290af9db9a02d83f6.jpg",
            language: ["English"],
            IMDb_rating: 9.0,
            runtime: "2h 32m",
            story: "Set within a year after the events of Batman Begins (2005), Batman, Lieutenant James Gordon, and new District Attorney Harvey Dent begin to round up Gotham's criminals, until a sadistic criminal mastermind known as The Joker appears."
        ),
        Movie(
            id: "2",
            name: "The Shawshank Redemption",
            rating: "R",
            genre: ["Drama"],
            poster: "https://i.imghippo.com/files/mHB5371A.jpg",
            language: ["English"],
            IMDb_rating: 9.3,
            runtime: "2h 22m",
            story: "Chronicles the experiences of a formerly successful banker as a prisoner in the gloomy jailhouse of Shawshank after being found guilty of a crime he did not commit."
        )
    ]
}




struct MoviesCenterView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesCenterView(userImage: "")
    }
}

