//
//  DetaiMovieViewModel.swift
//  TheBestMoviesSwiftUI
//
//  Created by Macbook Pro on 28/9/2023.
//

import Foundation
import Factory


class DetaiMovieViewModel: ObservableObject {
    @Published var detailMovie : DetailMovie?
    @Published var errorMsg: String = ""
    
    fileprivate var service : DetailMovieApiService
    
    init() {
        @Injected(\.ApiClientRepository) var apiClient : ApiClient
        service = DetailMovieApiService(apiClient: apiClient)
    }
    
    func getDetailMovie(movie: Movie) {
        service.getMovieDetail(movieId: movie.id) { [weak self] data, error in
            guard let self = self else { return }
            if error != nil {
                self.errorMsg = error?.description ?? "error"
            } else {
                self.detailMovie = data
                self.errorMsg = ""
            }
        }
    }
}
 
