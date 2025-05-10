//
//  HomeViewModel.swift
//  Movie-Task-V2
//
//  Created by Sabri Çetin on 10.05.2025.
//

import Foundation
import Combine

final class HomeViewModel: ObservableObject {
    // MARK: - Published Properties (UI'ya yansıyacak veriler)
    @Published var trendingMovies: [Movie] = []
    @Published var topRatedMovies: [Movie] = []
    @Published var popularMovies: [Movie] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    // MARK: - Private
    private let service = MovieService()
    private var cancellables = Set<AnyCancellable>()

    // MARK: - Init
    init() {
        fetchAllMovieLists()
    }

    // MARK: - Fetch
    func fetchAllMovieLists() {
        isLoading = true

        let trendingPublisher = service.fetchTrending()
        let topRatedPublisher = service.fetchTopRated()
        let popularPublisher = service.fetchPopular()

        Publishers.Zip3(trendingPublisher, topRatedPublisher, popularPublisher)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case let .failure(error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            } receiveValue: { [weak self] trending, topRated, popular in
                self?.trendingMovies = trending
                self?.topRatedMovies = topRated
                self?.popularMovies = popular
            }
            .store(in: &cancellables)
    }
    
    var allMoviesPublisher: AnyPublisher<[Movie], Never> {
        Publishers.CombineLatest3(
            $trendingMovies,
            $topRatedMovies,
            $popularMovies
        )
        .map { trending, topRated, popular in
            let combined = trending + topRated + popular
            let unique = Array(Set(combined)) // Aynı film üç listede olabilir, filtrele
            return unique
        }
        .eraseToAnyPublisher()
    }

}
