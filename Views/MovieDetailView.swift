//
//  MovieDetailView.swift
//  Movie-Task-V2
//
//  Created by Sabri Çetin on 10.05.2025.
//

import SwiftUI

struct MovieDetailView: View {
    let movie: Movie
    @EnvironmentObject var favorites: FavoritesManager


       var body: some View {
           ScrollView {
               VStack(alignment: .leading, spacing: 16) {
                   // MARK: - Poster
                   AsyncImage(url: movie.backdropURL ?? movie.posterURL) { image in
                       image
                           .resizable()
                                  .scaledToFit()
                                  .cornerRadius(16) // Belirgin köşe yumuşatma
                                  .clipped()
                                  .padding(.horizontal, 12)
                     
                   } placeholder: {
                       Color.gray.opacity(0.3)
                           .frame(height: 220)
                                  .cornerRadius(16)
                                  .padding(.horizontal, 12)
                   }

                   VStack(alignment: .leading, spacing: 8) {
                       // MARK: - Title
                       Text(movie.title)
                           .font(.title)
                           .bold()
                           .fixedSize(horizontal: false, vertical: true)

                       // MARK: - Rating & Date
                       HStack(spacing: 10) {
                           Text("⭐ \(movie.voteAverage, specifier: "%.1f")")
                           Text("🗓 \(movie.releaseDate ?? "Unknown")")

                           Spacer()

                           Button(action: {
                               favorites.toggle(movie)
                           }) {
                               Image(systemName: favorites.isFavorite(movie) ? "heart.fill" : "heart")
                                   .foregroundColor(.red)
                                   .font(.title2)
                           }
                       }
                       .font(.subheadline)
                       .padding(.trailing, 8)


                       // MARK: - Overview
                       Text(movie.overview)
                           .font(.body)
                           .fixedSize(horizontal: false, vertical: true)
                   }
                   .padding(.horizontal)
               }
               .padding(.bottom, 20)
           }
           .navigationTitle(movie.title)
           .navigationBarTitleDisplayMode(.inline)
       }
}


