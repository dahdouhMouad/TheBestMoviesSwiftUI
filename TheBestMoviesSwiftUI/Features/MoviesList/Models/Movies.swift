//
//  Movies.swift
//  TheBestMovies
//
//  Created by Macbook Pro on 23/8/2023.
//

import Foundation

// MARK: - MoviesData
struct MoviesData: Codable {
    var page: Int
    var movies: [Movie]
    var totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page
        case movies = "results"
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct Movie: Codable,MovieProtocol,Hashable {
    var adult: Bool
    var backdropPath: String
    var genreIDS: [Int]
    var id: Int
    var originalLanguage: String
    var originalTitle, overview: String
    var popularity: Double
    var posterPath, releaseDate, title: String
    var video: Bool
    var voteAverage: Double
    var voteCount: Int
    static var posterBaseUrl: String = Endpoints.smallImageBaseUrl

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
    
    static let sample = Movie(adult: false, backdropPath: "", genreIDS: [0], id: 565770, originalLanguage: "", originalTitle: "", overview: "", popularity: 0.0, posterPath: "/4Y1WNkd88JXmGfhtWR7dmDAo1T2.jpg", releaseDate: "", title: "TestTestTestTestTestTestTestTestTestTest", video: false, voteAverage: 0.0, voteCount: Int(0.0))
}

