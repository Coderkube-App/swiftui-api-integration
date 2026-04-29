//
// Copyright (c) 2026 Coderkube Technologies - Swiftui-api-integration-boilerplate. All rights reserved.
//

import Foundation

public protocol MovieRepositoryProtocol {
  func fetchMovies(page: Int) async throws -> [Movie]
  func fetchMovieDetail(id: Int) async throws -> MovieDetail
}
