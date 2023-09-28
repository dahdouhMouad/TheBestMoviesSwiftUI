//
//  MoviesListApiService.swift
//  TheBestMoviesSwiftUI
//
//  Created by Macbook Pro on 28/9/2023.
//

import Foundation

protocol MoviesListService {
    func getMoviesList(completion: @escaping (MoviesData?, String?) -> Void)
    func getMovieDetail(movieId: Int,completion: @escaping (DetailMovie?, String?) -> Void)
}

class MoviesListApiService {

    let apiClient: ApiClient

    // MARK: - Init
    init(apiClient: ApiClient) {
        self.apiClient = apiClient
    }

}

extension MoviesListApiService: MoviesListService {
    func getMoviesList(completion: @escaping (MoviesData?, String?) -> Void) {
        self.apiClient.GET(Endpoints.trendingMovies.fullPath) { (result: Result<MoviesData, APIError>) in
            switch result {
                case .success(let response):
                    completion(response, nil)
                case .failure(let error):
                    completion(nil, error.localizedDescription)
            }
        }
    }
    
    func getMovieDetail(movieId: Int,completion: @escaping (DetailMovie?, String?) -> Void) {
        self.apiClient.GET(Endpoints.detailOfMovie(movieId).fullPath) { (result: Result<DetailMovie, APIError>) in
            switch result {
                case .success(let response):
                    completion(response, nil)
                case .failure(let error):
                    completion(nil, error.localizedDescription)
            }
        }
    }
}

