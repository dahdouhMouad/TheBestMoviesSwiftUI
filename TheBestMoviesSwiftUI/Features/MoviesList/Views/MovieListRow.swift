//
//  MovieListRow.swift
//  TheBestMoviesSwiftUI
//
//  Created by Macbook Pro on 28/9/2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct MovieListRow: View {
    var movie : Movie
    var body: some View {
        HStack() {
            WebImage(url: URL(string: movie.getPosterImageUrl()))
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 140,maxHeight: 200)
            VStack(alignment:.leading,spacing: 4) {
                Group {
                    Text(movie.title)
                        .multilineTextAlignment(.leading)
                        .font(.headline)
                    Text(movie.releaseDate.getYearFromDate() ?? "")
                        .font(.subheadline)
                }
            }
        }
        .foregroundColor(.black)
    }
}

struct MovieListRow_Previews: PreviewProvider {
    static var previews: some View {
        LazyVStack {
            MovieListRow(movie: Movie.sample)
        }
    }
}
