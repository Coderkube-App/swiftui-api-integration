//
// Copyright (c) 2026 Coderkube Technologies - Swiftui-api-integration-boilerplate. All rights reserved.
//

import Foundation

public protocol FetchMovieDetailUseCaseProtocol {
  func execute(id: Int) async throws -> MovieDetail
}

public struct FetchMovieDetailUseCase: FetchMovieDetailUseCaseProtocol {
  private let repository: MovieRepositoryProtocol
  
  public init(repository: MovieRepositoryProtocol) {
    self.repository = repository
  }
  
  public func execute(id: Int) async throws -> MovieDetail {
    return try await repository.fetchMovieDetail(id: id)
  }
}
