//
//  FavoritesViewModel.swift
//  Movie-Task-V2
//
//  Created by Sabri Çetin on 10.05.2025.
//

import Foundation
import Combine

final class FavoritesViewModel: ObservableObject {
    @Published var favoriteMovies: [Movie] = []

    private var cancellables = Set<AnyCancellable>()

    func bind(favoritesManager: FavoritesManager) {
        favoritesManager.$favoriteMovies
            .receive(on: DispatchQueue.main)
            .assign(to: &$favoriteMovies)
    }
}
