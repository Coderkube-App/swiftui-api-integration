//
// Copyright (c) 2026 Coderkube Technologies - Swiftui-api-integration-boilerplate. All rights reserved.
//

import Foundation

public protocol RemoteMovieDataSourceProtocol {
  func fetchMovies(page: Int) async throws -> MovieListResponseDTO
  func fetchMovieDetail(id: Int) async throws -> MovieDetailDTO
}

public struct RemoteMovieDataSource: RemoteMovieDataSourceProtocol {
  private let networkService: NetworkServiceProtocol
  private let baseURL: String
  private let apiKey: String
  
  public init(networkService: NetworkServiceProtocol, baseURL: String, apiKey: String) {
    self.networkService = networkService
    self.baseURL = baseURL
    self.apiKey = apiKey
  }
  
  public func fetchMovies(page: Int) async throws -> MovieListResponseDTO {
    guard let url = URL(string: "\(baseURL)/discover/movie?api_key=\(apiKey)&page=\(page)") else {
      throw URLError(.badURL)
    }
    return try await networkService.request(url: url)
  }
  
  public func fetchMovieDetail(id: Int) async throws -> MovieDetailDTO {
    guard let url = URL(string: "\(baseURL)/movie/\(id)?api_key=\(apiKey)") else {
      throw URLError(.badURL)
    }
    return try await networkService.request(url: url)
  }
}
