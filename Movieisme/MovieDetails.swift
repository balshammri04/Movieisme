//
//  MovieDetails.swift
//  Movieisme
//
//  Created by bayan alshammri on 22/01/2025.
//

import SwiftUI

struct MovieDetailsView: View {
    // بيانات الفيلم التي تأتي من API
    @State var movie: Movie = Movie.placeholder // Placeholder لتجربة التصميم

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // صورة الفيلم
                Image("moviePlaceholder") // استبدل بـ AsyncImage للصور من الإنترنت
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 300)
                    .clipped()

                // اسم الفيلم
                Text(movie.title)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.horizontal)

                // معلومات أساسية
                HStack {
                    Text("Duration: \(movie.duration)")
                    Spacer()
                    Text("Language: \(movie.language)")
                }
                .font(.subheadline)
                .padding(.horizontal)

                HStack {
                    Text("Genre: \(movie.genre)")
                    Spacer()
                    Text("Age: \(movie.ageRating)+")
                }
                .font(.subheadline)
                .padding(.horizontal)

                // ملخص القصة
                Text("Story")
                    .font(.headline)
                    .padding(.horizontal)

                Text(movie.story)
                    .font(.body)
                    .padding(.horizontal)

                // تقييم الفيلم
                HStack {
                    Text("IMDb Rating: \(movie.imdbRating)/10")
                        .font(.subheadline)
                    Spacer()
                }
                .padding(.horizontal)

                // المخرج
                HStack {
                    Text("Director:")
                        .font(.headline)
                    Text(movie.director)
                        .font(.body)
                }
                .padding(.horizontal)

                // الممثلين
                VStack(alignment: .leading) {
                    Text("Stars:")
                        .font(.headline)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(movie.stars, id: \.self) { star in
                                VStack {
                                    Image(systemName: "person.fill") // استبدل بصور حقيقية إذا متوفرة
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                    Text(star)
                                        .font(.caption)
                                }
                                .padding(.horizontal, 10)
                            }
                        }
                    }
                }
                .padding(.horizontal)

                // التقييمات
                VStack(alignment: .leading) {
                    Text("Rating & Reviews")
                        .font(.headline)
                    ForEach(movie.reviews, id: \.id) { review in
                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                Text(review.username)
                                    .font(.subheadline)
                                    .bold()
                                Spacer()
                                Text("\(review.rating, specifier: "%.1f") / 5")
                                    .font(.subheadline)
                            }
                            Text(review.comment)
                                .font(.body)
                        }
                        .padding(.vertical, 8)
                        .padding(.horizontal)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                    }
                }
                .padding(.horizontal)

                // أزرار التفاعل
                HStack {
                    Button(action: {
                        // منطق حفظ الفيلم
                    }) {
                        Label("Save", systemImage: "bookmark")
                    }
                    .buttonStyle(.bordered)

                    Button(action: {
                        // منطق مشاركة الفيلم
                    }) {
                        Label("Share", systemImage: "square.and.arrow.up")
                    }
                    .buttonStyle(.bordered)
                }
                .padding()
            }
        }
        .onAppear {
           
        }
    }

 
        }
    

struct MovieDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailsView()
    }
}

