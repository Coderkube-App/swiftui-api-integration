//
// Copyright (c) 2026 Coderkube Technologies - Swiftui-api-integration-boilerplate. All rights reserved.
//

import SwiftUI

public struct MovieRowView: View {
  let movie: Movie
  
  public init(movie: Movie) {
    self.movie = movie
  }
  
  public var body: some View {
    VStack(alignment: .leading, spacing: 8) {
      HStack(alignment: .top, spacing: 12) {
        if let posterPath = movie.posterPath, let url = URL(string: "https://image.tmdb.org/t/p/w200\(posterPath)") {
          AsyncImage(url: url) { image in
            image
              .resizable()
              .aspectRatio(contentMode: .fill)
          } placeholder: {
            Color.gray.opacity(0.3)
          }
          .frame(width: 80, height: 120)
          .cornerRadius(8)
          .clipped()
        } else {
          Color.gray.opacity(0.3)
            .frame(width: 80, height: 120)
            .cornerRadius(8)
        }
        
        VStack(alignment: .leading, spacing: 4) {
          Text(movie.title)
            .font(.headline)
            .fontWeight(.bold)
            .foregroundColor(.primary)
          
          Text(movie.releaseDate)
            .font(.subheadline)
            .foregroundColor(.primary)
          
          HStack(spacing: 4) {
            Image(systemName: "hand.thumbsup.fill")
              .resizable()
              .aspectRatio(21/20, contentMode: .fit)
              .frame(height: 20)
              .foregroundColor(Color(red: 0.957, green: 0.788, blue: 0.0))
            Text(String(format: "%.1f", movie.voteAverage))
              .font(.subheadline)
              .foregroundColor(.primary)
          }
        }
      }
      
      Text(movie.overview)
        .font(.caption)
        .foregroundColor(.secondary)
        .lineLimit(4)
        .multilineTextAlignment(.leading)
    }
    .padding(.vertical, 8)
  }
}
