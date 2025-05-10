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

    init() {}
}

extension FavoritesViewModel {
    static let placeholder = FavoritesViewModel()

    func configure(favoritesManager: FavoritesManager, allMoviesPublisher: AnyPublisher<[Movie], Never>) {
        allMoviesPublisher
            .combineLatest(favoritesManager.$favoriteIDs)
            .map { allMovies, ids in
                allMovies.filter { ids.contains($0.id) }
            }
            .receive(on: DispatchQueue.main)
            .assign(to: &$favoriteMovies)
    }
}
