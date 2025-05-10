//
//  HomeView.swift
//  Movie-Task-V2
//
//  Created by Sabri Çetin on 10.05.2025.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    @State private var trendingIndex = 0
    private let timer = Timer.publish(every: 3.5, on: .main, in: .common).autoconnect()
    @State private var selectedMovie: Movie?
    @State private var isDetailActive = false

    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // MARK: Trending Slider
                    if !viewModel.trendingMovies.isEmpty {
                        trendingSection
                    }
                    
                    // MARK: Top Rated
                    if !viewModel.topRatedMovies.isEmpty {
                        movieRowSection(title: "⭐ Top Rated", movies: viewModel.topRatedMovies)
                    }
                    
                    // MARK: Popular
                    if !viewModel.popularMovies.isEmpty {
                        movieRowSection(title: "📈 Popular", movies: viewModel.popularMovies)
                    }
                }
                .padding(.horizontal)
                .padding(.top, 8)
            }
            .navigationTitle("🎬 Movies")
        }
    }
    
    private var trendingSection: some View {
        TabView(selection: $trendingIndex) {
            ForEach(viewModel.trendingMovies.indices, id: \.self) { index in
                let movie = viewModel.trendingMovies[index]

                ZStack(alignment: .bottomLeading) {
                    // Invisible NavigationLink
                    NavigationLink(destination: MovieDetailView(movie: movie)) {
                        EmptyView()
                    }
                    .opacity(0)
                    .frame(width: 0, height: 0)

                    // Main Tap Area
                    Button {
                        selectedMovie = movie
                        isDetailActive = true
                    } label: {
                        ZStack(alignment: .bottomLeading) {
                            AsyncImage(url: movie.backdropURL) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                            } placeholder: {
                                Color.gray.opacity(0.3)
                            }
                            .frame(height: 200)
                            .cornerRadius(12)
                            .clipped()

                            LinearGradient(
                                gradient: Gradient(colors: [.black.opacity(0.8), .clear]),
                                startPoint: .bottom,
                                endPoint: .top
                            )
                            .cornerRadius(12)
                            .frame(height: 80)
                            .overlay(
                                Text(movie.title)
                                    .foregroundColor(.white)
                                    .font(.headline)
                                    .padding([.leading, .bottom], 12),
                                alignment: .bottomLeading
                            )
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .tag(index)
            }
        }
        .frame(height: 220)
        .tabViewStyle(PageTabViewStyle())
        .onReceive(timer) { _ in
            withAnimation {
                trendingIndex = (trendingIndex + 1) % viewModel.trendingMovies.count
            }
        }
        // Navigation wrapper
        .background(
            NavigationLink(
                destination: selectedMovie.map { MovieDetailView(movie: $0) },
                isActive: $isDetailActive
            ) {
                EmptyView()
            }
            .hidden()
        )
    }
    
    private func movieRowSection(title: String, movies: [Movie]) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.title2)
                .bold()
                .padding(.leading, 4)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(movies.prefix(10)) { movie in
                        NavigationLink(destination: MovieDetailView(movie: movie)) {
                            VStack(alignment: .leading, spacing: 4) {
                                AsyncImage(url: movie.posterURL) { image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                } placeholder: {
                                    Color.gray.opacity(0.2)
                                }
                                .frame(width: 120, height: 180)
                                .cornerRadius(8)
                                .clipped()
                                
                                Text(movie.title)
                                    .font(.caption)
                                    .lineLimit(1)
                            }
                            .frame(width: 120)
                        }
                        .buttonStyle(PlainButtonStyle()) // Görünüm bozulmasın diye
                    }
                }
                .padding(.horizontal, 4)
            }
        }
    }
    
}

