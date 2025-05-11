//
//  FavoritesManager.swift
//  Movie-Task-V2
//
//  Created by Sabri Çetin on 10.05.2025.
//

import Foundation
import Combine

final class FavoritesManager: ObservableObject {
    @Published private(set) var favoriteIDs: [Int] = []
    @Published private(set) var favoriteMovies: [Movie] = []


    private let storageKey = "favorite_movie_ids"

    init() {
        loadFavorites()
    }

    func isFavorite(_ movie: Movie) -> Bool {
        favoriteIDs.contains(movie.id)
    }

    func toggle(_ movie: Movie) {
        
        print("🧪 \(movie.title) → posterPath: \(movie.posterPath ?? "nil")")

        if let index = favoriteIDs.firstIndex(of: movie.id) {
            // Favoriden çıkar
            favoriteIDs.remove(at: index)
            favoriteMovies.removeAll { $0.id == movie.id }
        } else {
            // Favoriye ekle (en üste)
            favoriteIDs.insert(movie.id, at: 0)
            favoriteMovies.insert(movie, at: 0)
        }

        saveFavorites()
    }

    private func loadFavorites() {
        if let idData = UserDefaults.standard.data(forKey: "favorite_movie_ids"),
           let decodedIDs = try? JSONDecoder().decode([Int].self, from: idData) {
            favoriteIDs = decodedIDs
        }

        if let movieData = UserDefaults.standard.data(forKey: "favorite_movie_objects"),
           let decodedMovies = try? JSONDecoder().decode([Movie].self, from: movieData) {
            favoriteMovies = decodedMovies
        }
    }


    private func saveFavorites() {
        if let idData = try? JSONEncoder().encode(favoriteIDs) {
            UserDefaults.standard.set(idData, forKey: "favorite_movie_ids")
        }

        if let movieData = try? JSONEncoder().encode(favoriteMovies) {
            UserDefaults.standard.set(movieData, forKey: "favorite_movie_objects")
        }
    }

}
