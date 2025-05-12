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

    func fetchTrending(page: Int) -> AnyPublisher<MovieResponse, Error> {
        guard var urlComponents = URLComponents(string: "\(MovieConstants.baseURL)/trending/movie/week") else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }

        urlComponents.queryItems = [
            URLQueryItem(name: "api_key", value: MovieConstants.apiKey),
            URLQueryItem(name: "language", value: "en-US"),
            URLQueryItem(name: "page", value: "\(page)")
        ]

        guard let url = urlComponents.url else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }

        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: MovieResponse.self, decoder: decoder)
            .eraseToAnyPublisher()
    }


    func fetchTopRated(page: Int) -> AnyPublisher<MovieResponse, Error> {
        guard var urlComponents = URLComponents(string: "\(MovieConstants.baseURL)/movie/top_rated") else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }

        urlComponents.queryItems = [
            URLQueryItem(name: "api_key", value: MovieConstants.apiKey),
            URLQueryItem(name: "language", value: "en-US"),
            URLQueryItem(name: "page", value: "\(page)")
        ]

        guard let url = urlComponents.url else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }

        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: MovieResponse.self, decoder: decoder)
            .eraseToAnyPublisher()
    }


    func fetchPopular(page: Int) -> AnyPublisher<MovieResponse, Error> {
        guard var urlComponents = URLComponents(string: "\(MovieConstants.baseURL)/movie/popular") else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }

        urlComponents.queryItems = [
            URLQueryItem(name: "api_key", value: MovieConstants.apiKey),
            URLQueryItem(name: "language", value: "en-US"),
            URLQueryItem(name: "page", value: "\(page)")
        ]

        guard let url = urlComponents.url else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }

        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: MovieResponse.self, decoder: decoder)
            .eraseToAnyPublisher()
    }

}
