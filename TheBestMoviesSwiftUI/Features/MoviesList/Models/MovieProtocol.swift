//
//  MovieProtocol.swift
//  TheBestMovies
//
//  Created by Macbook Pro on 24/8/2023.
//

import Foundation

protocol MovieProtocol {
    var posterPath: String { get }
    var backdropPath: String { get }
    static var posterBaseUrl: String { get }
}

// Provide a default implementation of a method to get the poster URL for any type conforming to MovieProtocol
extension MovieProtocol {
    func getPosterImageUrl() -> String {
        return Self.posterBaseUrl + posterPath
    }
    
    func getBackDropImageUrl() -> String {
        return Self.posterBaseUrl + backdropPath
    }
    
}


//Documentation
/*
Example of Images
 https://image.tmdb.org/t/p/original/wwemzKWzjKYJFfCeiB57q3r4Bcm.svg
 https://image.tmdb.org/t/p/original/wwemzKWzjKYJFfCeiB57q3r4Bcm.png
 https://image.tmdb.org/t/p/w500/wwemzKWzjKYJFfCeiB57q3r4Bcm.png
*/
