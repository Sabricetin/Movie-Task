//
//  HomeViewModel.swift
//  Movie-Task-V2
//
//  Created by Sabri Çetin on 10.05.2025.
//

import Foundation
import Combine

final class HomeViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var trendingMovies: [Movie] = []
    @Published var topRatedMovies: [Movie] = []
    @Published var popularMovies: [Movie] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    // MARK: - Private
    private let service = MovieService()
    private var cancellables = Set<AnyCancellable>()

    // MARK: - Pagination State
    private var currentTopRatedPage = 1
    private var totalTopRatedPages = 1
    private var isLoadingTopRated = false

    private var currentPopularPage = 1
    private var totalPopularPages = 1
    private var isLoadingPopular = false

    private var currentTrendingPage = 1
    private var totalTrendingPages = 1
    private var isLoadingTrending = false

    // MARK: - Init
    init() {
        loadMoreTopRated()
        loadMoreTrending()
        loadMorePopular()
    }

    // MARK: - Infinite Scroll Loaders

    func loadMoreTopRated() {
        guard !isLoadingTopRated, currentTopRatedPage <= totalTopRatedPages else { return }

        isLoadingTopRated = true

        service.fetchTopRated(page: currentTopRatedPage)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoadingTopRated = false
                if case let .failure(error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            } receiveValue: { [weak self] response in
                self?.topRatedMovies.append(contentsOf: response.results)
                self?.currentTopRatedPage += 1
                self?.totalTopRatedPages = response.totalPages
            }
            .store(in: &cancellables)
    }

    func loadMoreTrending() {
        guard !isLoadingTrending, currentTrendingPage <= totalTrendingPages else { return }

        isLoadingTrending = true

        service.fetchTrending(page: currentTrendingPage)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoadingTrending = false
                if case let .failure(error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            } receiveValue: { [weak self] response in
                self?.trendingMovies.append(contentsOf: response.results)
                self?.currentTrendingPage += 1
                self?.totalTrendingPages = response.totalPages
            }
            .store(in: &cancellables)
    }

    func loadMorePopular() {
        guard !isLoadingPopular, currentPopularPage <= totalPopularPages else { return }

        isLoadingPopular = true

        service.fetchPopular(page: currentPopularPage)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoadingPopular = false
                if case let .failure(error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            } receiveValue: { [weak self] response in
                self?.popularMovies.append(contentsOf: response.results)
                self?.currentPopularPage += 1
                self?.totalPopularPages = response.totalPages
            }
            .store(in: &cancellables)
    }

    // MARK: - Combine All Movies (for Favorites)
    var allMoviesPublisher: AnyPublisher<[Movie], Never> {
        Publishers.CombineLatest3(
            $trendingMovies,
            $topRatedMovies,
            $popularMovies
        )
        .map { trending, topRated, popular in
            let combined = trending + topRated + popular
            let unique = Array(Set(combined))
            return unique
        }
        .eraseToAnyPublisher()
    }
}
