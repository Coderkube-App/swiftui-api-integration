//
// Copyright (c) 2026 Coderkube Technologies - SwiftUICleanArchitectureApp. All rights reserved.
//

import SwiftUI

/// Centralized Dependency Injection Container.
/// Manages the creation of dependencies for each layer.
@MainActor
public class DIContainer {
  
  // Configurable API URL and Key
  private let apiBaseURL = "https://api.themoviedb.org/3"
  private let apiKey = "YOUR_API_KEY_HERE"
  
  public init() {}
  
  // MARK: - Core / Network
  private func makeNetworkService() -> NetworkServiceProtocol {
    return DefaultNetworkService()
  }
  
  // MARK: - Data Layer
  private func makeRemoteMovieDataSource() -> RemoteMovieDataSourceProtocol {
    return RemoteMovieDataSource(
      networkService: makeNetworkService(),
      baseURL: apiBaseURL,
      apiKey: apiKey
    )
  }
  
  private func makeMovieRepository() -> MovieRepositoryProtocol {
    return MovieRepositoryImpl(remoteDataSource: makeRemoteMovieDataSource())
  }
  
  // MARK: - Domain Layer
  private func makeFetchMoviesUseCase() -> FetchMoviesUseCaseProtocol {
    return FetchMoviesUseCase(repository: makeMovieRepository())
  }
  
  private func makeFetchMovieDetailUseCase() -> FetchMovieDetailUseCaseProtocol {
    return FetchMovieDetailUseCase(repository: makeMovieRepository())
  }
  
  // MARK: - Presentation Layer
  public func makeMovieListViewModel() -> MovieListViewModel {
    return MovieListViewModel(fetchMoviesUseCase: makeFetchMoviesUseCase())
  }
  
  public func makeMovieDetailViewModel(movieId: Int) -> MovieDetailViewModel {
    return MovieDetailViewModel(movieId: movieId, fetchMovieDetailUseCase: makeFetchMovieDetailUseCase())
  }
  
  public func makeMovieListView(onMovieSelected: ((Movie) -> Void)?) -> some View {
    // Delaying initialization to be done via closure to avoid holding state statically
    return MovieListView(viewModel: self.makeMovieListViewModel(), onMovieSelected: onMovieSelected)
  }
  
  public func makeMovieDetailView(movieId: Int) -> some View {
    return MovieDetailView(viewModel: self.makeMovieDetailViewModel(movieId: movieId))
  }
}
