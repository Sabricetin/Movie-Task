//
//  MovieService.swift
//  Movie-Task-V2
//
//  Created by Sabri Çetin on 10.05.2025.
//

import Foundation
import Combine

final class MovieService {
    private let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .useDefaultKeys
        return decoder
    }()

    // Genel veri çekme fonksiyonu
    private func fetch(from path: String) -> AnyPublisher<[Movie], Error> {
        guard var urlComponents = URLComponents(string: "\(MovieConstants.baseURL)/\(path)") else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }

        urlComponents.queryItems = [
            URLQueryItem(name: "api_key", value: MovieConstants.apiKey),
            URLQueryItem(name: "language", value: "en-US"),
            URLQueryItem(name: "page", value: "1")
        ]

        guard let url = urlComponents.url else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }

        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: MovieResponse.self, decoder: decoder)
            .map(\.results)
            .eraseToAnyPublisher()
    }

    // MARK: - Public Functions

    func fetchTrending() -> AnyPublisher<[Movie], Error> {
        fetch(from: "trending/movie/week")
    }

    func fetchTopRated() -> AnyPublisher<[Movie], Error> {
        fetch(from: "movie/top_rated")
    }

    func fetchPopular() -> AnyPublisher<[Movie], Error> {
        fetch(from: "movie/popular")
    }
}
