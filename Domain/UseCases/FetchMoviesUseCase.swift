//
// Copyright (c) 2026 Coderkube Technologies - Swiftui-api-integration-boilerplate. All rights reserved.
//

import Foundation

public protocol FetchMoviesUseCaseProtocol {
  func execute(page: Int) async throws -> [Movie]
}

public struct FetchMoviesUseCase: FetchMoviesUseCaseProtocol {
  private let repository: MovieRepositoryProtocol
  
  public init(repository: MovieRepositoryProtocol) {
    self.repository = repository
  }
  
  public func execute(page: Int) async throws -> [Movie] {
    return try await repository.fetchMovies(page: page)
  }
}
