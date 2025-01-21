//
//  MoviesCenter.swift
//  Movieisme
//
//  Created by bayan alshammri on 21/01/2025.
//
import SwiftUI

struct MoviesContainerView: View {
    @State private var searchQuery: String = ""
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                   
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
                            ForEach(1...5, id: \.self) { index in
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(Color.blue.opacity(0.3))

                                
                            }
                            
                        }
                        .frame(width: 355, height: 429)
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                    }
                    .padding(.horizontal)

                    
                    // Movie Categories
                    MovieCategoryView(categoryName: "Drama")
                    MovieCategoryView(categoryName: "Comedy")
                }
            }
            
            .navigationTitle("Movies Center")
            
        }
    }
}

struct MovieCategoryView: View {
    let categoryName: String
    
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
                    ForEach(1...5, id: \.self) { index in
                       RoundedRectangle(cornerRadius: 12)
                            .fill(Color.green.opacity(0.3))
                            .frame(width: 208, height: 275)
                            
                    }
                }
               .padding(.horizontal)
            }
        }
        .padding(.vertical)
    }
}

struct MoviesContainerView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesContainerView()
    }
}
