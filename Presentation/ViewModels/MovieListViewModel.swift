//
// Copyright (c) 2026 Coderkube Technologies - SwiftUICleanArchitectureApp. All rights reserved.
//

import Foundation
import Combine

@MainActor
public class MovieListViewModel: ObservableObject {
  @Published public var state: ViewState<[Movie]> = .idle
  @Published public var movies: [Movie] = []
  @Published public var isLoadingMore: Bool = false
  @Published public var isRefreshing: Bool = false
  
  private let fetchMoviesUseCase: FetchMoviesUseCaseProtocol
  private var allFetchedMovies: [Movie] = []
  private var currentAppPage: Int = 1
  private var currentTmdbPage: Int = 1
  private let itemsPerPage: Int = 10
  private var hasMoreData: Bool = true
  
  public init(fetchMoviesUseCase: FetchMoviesUseCaseProtocol) {
    self.fetchMoviesUseCase = fetchMoviesUseCase
  }
  
  public func loadMovies(isRefreshing: Bool = false) async {
    if isRefreshing {
      currentAppPage = 1
      currentTmdbPage = 1
      allFetchedMovies = []
      hasMoreData = true
      self.isRefreshing = true
    } else {
      guard hasMoreData && !isLoadingMore else { return }
      if movies.isEmpty {
        state = .loading
      } else {
        isLoadingMore = true
      }
    }
    
    do {
      // Simulate network delay so the bottom loader is visible to the user
      if isLoadingMore {
        try? await Task.sleep(nanoseconds: 500_000_000) // 0.5s
      }
      
      // If we don't have enough items cached for the next app page, fetch from TMDB
      if allFetchedMovies.count < currentAppPage * itemsPerPage {
        let fetchedMovies = try await fetchMoviesUseCase.execute(page: currentTmdbPage)
        if fetchedMovies.isEmpty {
          hasMoreData = false
        } else {
          allFetchedMovies.append(contentsOf: fetchedMovies)
          currentTmdbPage += 1
        }
      }
      
      updateState()
    } catch {
      if movies.isEmpty {
        state = .error(error.localizedDescription)
      }
      isLoadingMore = false
      self.isRefreshing = false
    }
  }
  
  public func loadMoreIfNeeded(currentItem: Movie) async {
    guard currentItem == movies.last else { return }
    await loadMovies()
  }
  
  private func updateState() {
    let limit = min(currentAppPage * itemsPerPage, allFetchedMovies.count)
    self.movies = Array(allFetchedMovies.prefix(limit))
    self.state = .success(self.movies)
    
    // Check if we've reached the end of all possible data
    if !hasMoreData && limit == allFetchedMovies.count {
      hasMoreData = false
    } else {
      currentAppPage += 1
    }
    
    self.isLoadingMore = false
    self.isRefreshing = false
  }
}
