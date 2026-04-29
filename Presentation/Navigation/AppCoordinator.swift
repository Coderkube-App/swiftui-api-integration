//
// Copyright (c) 2026 Coderkube Technologies - Swiftui-api-integration-boilerplate. All rights reserved.
//

import SwiftUI

/// Coordinator handles navigation logic separately from views.
@MainActor
public class AppCoordinator: ObservableObject {
  @Published public var navigationPath = NavigationPath()
  private let diContainer: DIContainer
  
  public init(diContainer: DIContainer) {
    self.diContainer = diContainer
  }
  
  public func start() -> some View {
    diContainer.makeMovieListView(onMovieSelected: { [weak self] movie in
      self?.navigateToMovieDetail(movie: movie)
    })
    .navigationDestination(for: Route.self) { route in
      self.resolveRoute(route)
    }
  }
  
  private func navigateToMovieDetail(movie: Movie) {
    navigationPath.append(Route.movieDetail(movie))
  }
  
  @ViewBuilder
  private func resolveRoute(_ route: Route) -> some View {
    switch route {
    case .movieDetail(let movie):
      diContainer.makeMovieDetailView(movieId: movie.id)
    }
  }
}

public enum Route: Hashable {
  case movieDetail(Movie)
  
  public static func == (lhs: Route, rhs: Route) -> Bool {
    switch (lhs, rhs) {
    case (.movieDetail(let lMovie), .movieDetail(let rMovie)):
      return lMovie.id == rMovie.id
    }
  }
  
  public func hash(into hasher: inout Hasher) {
    switch self {
    case .movieDetail(let movie):
      hasher.combine(movie.id)
    }
  }
}
