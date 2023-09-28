//
//  ContentView.swift
//  TheBestMoviesSwiftUI
//
//  Created by Macbook Pro on 28/9/2023.
//

import SwiftUI

struct MoviesListView: View {
    
    @StateObject var viewModel = MoviesListViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(alignment:.leading) {
                    ForEach($viewModel.movies,id: \.title) { movie in
                        NavigationLink(value: movie.wrappedValue) {
                            MovieListRow(movie: movie.wrappedValue)
                        }
                        Divider()
                    }
                }
                .onAppear {
                    let apparence = UINavigationBarAppearance()
                    
                    apparence.backgroundColor = UIColor(.accentColor.opacity(0.25))
                    
                    UINavigationBar.appearance().standardAppearance = apparence
                    UINavigationBar.appearance().scrollEdgeAppearance = apparence
                }
            }
            .padding()
            .navigationTitle("Popular Movies")
            .navigationBarTitleDisplayMode(.large)
            .navigationDestination(for: Movie.self, destination: { movie in
                DetailMovieView(movie: movie)
            })
            .task {
                viewModel.getHome()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesListView()
    }
}
