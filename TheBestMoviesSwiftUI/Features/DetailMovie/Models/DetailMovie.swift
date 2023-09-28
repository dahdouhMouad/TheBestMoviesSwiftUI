//
//  DetailMovie.swift
//  TheBestMovies
//
//  Created by Macbook Pro on 24/8/2023.
//

import Foundation

struct DetailMovie: Codable,MovieProtocol {
    var adult: Bool
    var backdropPath: String
    var budget: Int
    var genres: [Genre]
    var homepage: String
    var id: Int
    var imdbID, originalLanguage, originalTitle, overview: String
    var popularity: Double
    var posterPath: String
    var releaseDate: String
    var revenue, runtime: Int
    var status, tagline, title: String
    var video: Bool
    var voteAverage: Double
    var voteCount: Int
    static var posterBaseUrl: String = Endpoints.originalImageBaseUrl

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case budget, genres, homepage, id
        case imdbID = "imdb_id"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case revenue, runtime
        case status, tagline, title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

// MARK: - Genre
struct Genre: Codable {
    let id: Int
    let name: String
}

