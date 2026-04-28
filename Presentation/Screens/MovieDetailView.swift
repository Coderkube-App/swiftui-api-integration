//
// Copyright (c) 2026 Coderkube Technologies - SwiftUICleanArchitectureApp. All rights reserved.
//

import SwiftUI

public struct MovieDetailView: View {
  @StateObject private var viewModel: MovieDetailViewModel
  
  public init(viewModel: MovieDetailViewModel) {
    _viewModel = StateObject(wrappedValue: viewModel)
  }
  
  public var body: some View {
    ScrollView {
      switch viewModel.state {
      case .idle, .loading:
        ProgressView("Loading Details...")
          .frame(maxWidth: .infinity, maxHeight: .infinity)
          .padding(.top, 100)
      case .success(let movie):
        VStack(alignment: .leading, spacing: 0) {
          
          // Backdrop Image
          if let backdropPath = movie.backdropPath, let url = URL(string: "https://image.tmdb.org/t/p/w1280\(backdropPath)") {
            AsyncImage(url: url) { image in
              image
                .resizable()
                .aspectRatio(contentMode: .fill)
            } placeholder: {
              Color.gray.opacity(0.3)
            }
            .frame(height: 220)
            .clipped()
          } else {
            Color.gray.opacity(0.3)
              .frame(height: 220)
          }
          
          // Poster and Title Section
          HStack(alignment: .bottom, spacing: 16) {
            if let posterPath = movie.posterPath, let url = URL(string: "https://image.tmdb.org/t/p/w342\(posterPath)") {
              AsyncImage(url: url) { image in
                image
                  .resizable()
                  .aspectRatio(contentMode: .fill)
              } placeholder: {
                Color.gray.opacity(0.3)
              }
              .frame(width: 100, height: 150)
              .cornerRadius(8)
              .shadow(radius: 4)
              .offset(y: -40) // Overlap the backdrop
              .padding(.bottom, -40)
            }
            
            VStack(alignment: .leading, spacing: 8) {
              Text(movie.title)
                .font(.title3)
                .fontWeight(.bold)
              
              Text(movie.releaseDate)
                .font(.body)
            }
            .padding(.bottom, 16)
          }
          .padding(.horizontal)
          
          // Details Section
          VStack(alignment: .leading, spacing: 16) {
            HStack(spacing: 4) {
              Image(systemName: "hand.thumbsup.fill")
                .resizable()
                .aspectRatio(21/20, contentMode: .fit)
                .frame(height: 20)
                .foregroundColor(Color(red: 0.957, green: 0.788, blue: 0.0))
              Text(String(format: "%.1f", movie.voteAverage))
                .font(.body)
            }
            
            if !movie.genres.isEmpty {
              Text("Genres :\(movie.genres.map { $0.name }.joined(separator: ", "))")
                .font(.subheadline)
                .fontWeight(.medium)
            }
            
            if !movie.spokenLanguages.isEmpty {
              Text("Languages :\(movie.spokenLanguages.map { $0.name }.joined(separator: ", "))")
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundColor(.secondary)
            }
            
            if !movie.productionCompanies.isEmpty {
              Text("Production Companies :\(movie.productionCompanies.map { $0.name }.joined(separator: ", "))")
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundColor(.secondary)
            }
            
            Text(movie.overview)
              .font(.body)
              .foregroundColor(.secondary)
              .lineSpacing(4)
          }
          .padding()
        }
      case .error(let message):
        VStack {
          Text("Failed to load details")
            .foregroundColor(.red)
          Text(message)
            .multilineTextAlignment(.center)
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.top, 100)
      }
    }
    .navigationTitle(
      {
        if case .success(let movie) = viewModel.state {
          return movie.title
        } else {
          return "Movie Detail"
        }
      }()
    )
    .navigationBarTitleDisplayMode(.inline)
    .task {
      if case .idle = viewModel.state {
        await viewModel.loadMovieDetail()
      }
    }
  }
}
