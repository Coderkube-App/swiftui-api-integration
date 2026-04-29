//
// Copyright (c) 2026 Coderkube Technologies - Swiftui-api-integration-boilerplate. All rights reserved.
//

import Foundation
import Combine

@MainActor
public class MovieDetailViewModel: ObservableObject {
  @Published public var state: ViewState<MovieDetail> = .idle
  
  private let movieId: Int
  private let fetchMovieDetailUseCase: FetchMovieDetailUseCaseProtocol
  
  public init(movieId: Int, fetchMovieDetailUseCase: FetchMovieDetailUseCaseProtocol) {
    self.movieId = movieId
    self.fetchMovieDetailUseCase = fetchMovieDetailUseCase
  }
  
  public func loadMovieDetail() async {
    state = .loading
    do {
      let detail = try await fetchMovieDetailUseCase.execute(id: movieId)
      state = .success(detail)
    } catch {
      state = .error(error.localizedDescription)
    }
  }
}
