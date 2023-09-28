//
//  DetailMovieApiService.swift
//  TheBestMoviesSwiftUI
//
//  Created by Macbook Pro on 28/9/2023.
//

import Foundation

protocol DetailMovieService {
    func getMovieDetail(movieId: Int,completion: @escaping (DetailMovie?, String?) -> Void)
}

class DetailMovieApiService {

    let apiClient: ApiClient

    // MARK: - Init
    init(apiClient: ApiClient) {
        self.apiClient = apiClient
    }

}

extension DetailMovieApiService: DetailMovieService {
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


