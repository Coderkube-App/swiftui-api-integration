//
// Copyright (c) 2026 Coderkube Technologies - SwiftUICleanArchitectureApp. All rights reserved.
//

import SwiftUI

public struct MovieListView: View {
  @StateObject private var viewModel: MovieListViewModel
  private let onMovieSelected: ((Movie) -> Void)?
  
  public init(viewModel: MovieListViewModel, onMovieSelected: ((Movie) -> Void)? = nil) {
    _viewModel = StateObject(wrappedValue: viewModel)
    self.onMovieSelected = onMovieSelected
  }
  
  public var body: some View {
    Group {
      switch viewModel.state {
      case .idle, .loading:
        ProgressView("Loading Movies...")
      case .success(let movies):
        List {
          ForEach(movies) { movie in
            Button(action: {
              onMovieSelected?(movie)
            }) {
              MovieRowView(movie: movie)
            }
            .buttonStyle(.plain)
            .onAppear {
              Task {
                await viewModel.loadMoreIfNeeded(currentItem: movie)
              }
            }
          }
          
          if viewModel.isLoadingMore {
            HStack {
              Spacer()
              ProgressView("Loading...")
              Spacer()
            }
            .padding()
          }
        }
        .listStyle(.plain)
        .refreshable {
          await viewModel.loadMovies(isRefreshing: true)
        }
      case .error(let message):
        VStack {
          Text("Failed to load movies")
            .font(.headline)
            .foregroundColor(.red)
          Text(message)
            .font(.subheadline)
            .multilineTextAlignment(.center)
            .padding()
          Button("Retry") {
            Task {
              await viewModel.loadMovies()
            }
          }
          .buttonStyle(.borderedProminent)
        }
      }
    }
    .navigationTitle("Movie List")
    .navigationBarTitleDisplayMode(.inline)
    .task {
      if case .idle = viewModel.state {
        await viewModel.loadMovies()
      }
    }
  }
}
