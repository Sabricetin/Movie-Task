//
//  FavoritesView.swift
//  Movie-Task-V2
//
//  Created by Sabri Çetin on 10.05.2025.
//

import SwiftUI
import Combine

struct FavoritesView: View {
    @EnvironmentObject var favorites: FavoritesManager
       @EnvironmentObject var homeViewModel: HomeViewModel

       @StateObject private var viewModel: FavoritesViewModel

       init() {
           // viewModel init boş kalacak, @StateObject tanımı burada yapılmaz
           _viewModel = StateObject(wrappedValue: FavoritesViewModel.placeholder)
       }

       var body: some View {
           NavigationView {
               ScrollView {
                   if viewModel.favoriteMovies.isEmpty {
                       Text("No favorites yet.")
                           .font(.subheadline)
                           .foregroundColor(.gray)
                           .padding(.top, 100)
                   } else {
                       LazyVGrid(columns: [GridItem(.adaptive(minimum: 120), spacing: 16)], spacing: 16) {
                           ForEach(viewModel.favoriteMovies) { movie in
                               NavigationLink(destination: MovieDetailView(movie: movie)) {
                                   VStack {
                                       AsyncImage(url: movie.posterURL) { image in
                                           image
                                               .resizable()
                                               .scaledToFill()
                                       } placeholder: {
                                           Color.gray.opacity(0.2)
                                       }
                                       .frame(width: 120, height: 180)
                                       .cornerRadius(8)
                                       .clipped()

                                       Text(movie.title)
                                           .font(.caption)
                                           .lineLimit(1)
                                   }
                                   .frame(width: 120)
                               }
                               .buttonStyle(PlainButtonStyle())
                           }
                       }
                       .padding()
                   }
               }
               .navigationTitle("❤️ Favorites")
           }
           .onAppear {
               viewModel.configure(
                   favoritesManager: favorites,
                   allMoviesPublisher: homeViewModel.allMoviesPublisher
               )
           }
       }
}
