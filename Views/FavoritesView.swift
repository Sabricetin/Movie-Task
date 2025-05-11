//
//  FavoritesView.swift
//  Movie-Task-V2
//
//  Created by Sabri Çetin on 11.05.2025.
//

import SwiftUI


struct FavoritesView: View {
    @EnvironmentObject var favorites: FavoritesManager
    @EnvironmentObject var homeViewModel: HomeViewModel
    @StateObject private var viewModel = FavoritesViewModel()

    var body: some View {
        NavigationView {
            ScrollView {
                if viewModel.favoriteMovies.isEmpty {
                    Text("No favorites yet.")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .padding(.top, 100)
                } else {
                    LazyVStack(alignment: .leading, spacing: 12) {
                        ForEach(viewModel.favoriteMovies) { movie in
                            NavigationLink(destination: MovieDetailView(movie: movie)) {
                                FavoriteMovieRow(movie: movie)
                            }
                            .id(movie.id)
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .padding(.top)
                }
            }
            .navigationTitle("❤️ Favorites")
            .onAppear {
                viewModel.bind(favoritesManager: favorites)
            }
        }
    }
}

struct FavoriteMovieRow: View {
    let movie: Movie
    @StateObject private var loader = ImageLoader()

    var body: some View {
        HStack(spacing: 12) {
            if let url = movie.posterURL {
                if let image = loader.image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 80, height: 120)
                                .clipped()
                                .cornerRadius(8)
                } else {
                    Color.gray.opacity(0.2)
                        .onAppear {
                            loader.loadImage(from: url)
                        }
                }
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(movie.title)
                    .font(.headline)

                Text("📆 \(movie.releaseDate ?? "-")")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }

            Spacer()
        }
        .frame(height: 120)
        .cornerRadius(8)
        .clipped()
        .padding(.horizontal)
    }
}

