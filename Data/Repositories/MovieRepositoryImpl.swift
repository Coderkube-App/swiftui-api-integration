//
// Copyright (c) 2026 Coderkube Technologies - Swiftui-api-integration-boilerplate. All rights reserved.
//

import Foundation

public struct MovieRepositoryImpl: MovieRepositoryProtocol {
  private let remoteDataSource: RemoteMovieDataSourceProtocol
  
  public init(remoteDataSource: RemoteMovieDataSourceProtocol) {
    self.remoteDataSource = remoteDataSource
  }
  
  public func fetchMovies(page: Int) async throws -> [Movie] {
    let response = try await remoteDataSource.fetchMovies(page: page)
    return response.results.map { $0.toDomain() }
  }
  
  public func fetchMovieDetail(id: Int) async throws -> MovieDetail {
    let response = try await remoteDataSource.fetchMovieDetail(id: id)
    return response.toDomain()
  }
}
