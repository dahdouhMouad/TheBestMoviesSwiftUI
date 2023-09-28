//
//  MoviesListViewModel.swift
//  TheBestMoviesSwiftUI
//
//  Created by Macbook Pro on 28/9/2023.
//

import Foundation
import Factory

class MoviesListViewModel : ObservableObject {
        
    // MARK: - Properties
    fileprivate let service: MoviesListApiService
    
    @Published var movies: [Movie] = []
    
    // MARK: - Init
    init() {
        @Injected(\.ApiClientRepository) var apiClient: ApiClient
        self.service = MoviesListApiService(apiClient: apiClient)
    }
}

extension MoviesListViewModel {
    
    func getHome() {
        self.service.getMoviesList() { [weak self] data, error in
            guard let self = self else { return }
            if error == nil {
                self.movies = data?.movies ?? []
            }
        }
    }
}
