//
//  MovieResponse.swift
//  Movie-Task-V2
//
//  Created by Sabri Çetin on 10.05.2025.
//

struct MovieResponse: Codable {
    let page: Int
    let results: [Movie]
    let totalPages: Int
    let totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
