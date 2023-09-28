//
//  EndPoints.swift
//  TheBestMovies
//
//  Created by Macbook Pro on 23/8/2023.
//

import Foundation

enum Endpoints {
    static let baseURL = "https://api.themoviedb.org/3/"
    static let originalImageBaseUrl = "https://image.tmdb.org/t/p/original/"
    static let smallImageBaseUrl = "https://image.tmdb.org/t/p/w500/"
    
    case trendingMovies
    case detailOfMovie(_ id: Int)

    var fullPath: String {
        let path: String
        
        switch self {
        case .trendingMovies:
            path = "discover/movie"
        case .detailOfMovie(let id):
            path = "movie/\(id)"
        }
        
        return Endpoints.baseURL + path + "?api_key=c9856d0cb57c3f14bf75bdc6c063b8f3"
    }
}


