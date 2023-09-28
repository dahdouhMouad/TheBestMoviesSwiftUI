//
//  DetailMovieView.swift
//  TheBestMoviesSwiftUI
//
//  Created by Macbook Pro on 28/9/2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct DetailMovieView: View {
    @StateObject var viewModel = DetaiMovieViewModel()
    var movie: Movie
    
    @Environment((\.dismiss)) var dismiss
    
    var body: some View {
        ScrollView {
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "arrow.left")
                }
                Spacer()
            }
            .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
            .tint(.red)

            LazyVStack(spacing: 4) {
                HStack {
                    let adult = viewModel.detailMovie?.adult ?? false
                    Image(systemName: adult ? "18.circle.fill":"")
                    VStack {
                        Text(viewModel.detailMovie?.title ?? "")
                            .font(.largeTitle)
                            .multilineTextAlignment(.center)
                        GenresView(genres: viewModel.detailMovie?.genres ?? [])
                    }
                    .padding(4)
                }
                if let imageUrl = viewModel.detailMovie?.getBackDropImageUrl() {
                    TabView {
                        WebImage(url: URL(string:viewModel.detailMovie?.getPosterImageUrl() ?? ""))
                            .resizable()
                            .scaledToFit()
                        
                        WebImage(url: URL(string:imageUrl))
                            .resizable()
                            .scaledToFit()
                    }
                    .tabViewStyle(.page)
                    .frame(height: 300)
                    .indexViewStyle(
                        PageIndexViewStyle(backgroundDisplayMode: .always)
                    )
                    .background(
                        RoundedRectangle(cornerRadius: 0)
                            .fill(Color.gray.opacity(0.1))
                    )
                }
                Text(viewModel.detailMovie?.overview ?? "")
                    .font(.title3)
                    .padding()
                    .toolbar(.hidden)//For Navigation
                    
            }
        }
        .task {
            viewModel.getDetailMovie(movie: movie)
        }
        
    }
}

struct DetailMovieView_Previews: PreviewProvider {
    static var previews: some View {
        DetailMovieView(movie: Movie.sample)
    }
}

struct GenresView: View {
    var genres: [Genre] = []
    var body: some View {
        HStack {
            ForEach(genres,id: \.id) { genre in
                Text(genre.name)
                    .lineLimit(1)
                    .foregroundColor(.white)
                    .padding(8)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.accentColor)
                )
            }
        }
    }
}
