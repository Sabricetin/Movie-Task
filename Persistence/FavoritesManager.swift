//
//  FavoritesManager.swift
//  Movie-Task-V2
//
//  Created by Sabri Çetin on 10.05.2025.
//

import Foundation
import Combine

final class FavoritesManager: ObservableObject {
    @Published private(set) var favoriteIDs: Set<Int> = []

    private let storageKey = "favorite_movie_ids"

    init() {
        loadFavorites()
    }

    func isFavorite(_ movie: Movie) -> Bool {
        favoriteIDs.contains(movie.id)
    }

    func toggle(_ movie: Movie) {
        if isFavorite(movie) {
            favoriteIDs.remove(movie.id)
        } else {
            favoriteIDs.insert(movie.id)
        }
        saveFavorites()
    }

    private func loadFavorites() {
        if let data = UserDefaults.standard.data(forKey: storageKey),
           let decoded = try? JSONDecoder().decode(Set<Int>.self, from: data) {
            favoriteIDs = decoded
        }
    }

    private func saveFavorites() {
        if let encoded = try? JSONEncoder().encode(favoriteIDs) {
            UserDefaults.standard.set(encoded, forKey: storageKey)
        }
    }
}
