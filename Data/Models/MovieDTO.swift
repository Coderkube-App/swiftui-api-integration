//
// Copyright (c) 2026 Coderkube Technologies - Swiftui-api-integration-boilerplate. All rights reserved.
//

import Foundation

public struct MovieListResponseDTO: Decodable {
  public let page: Int
  public let results: [MovieDTO]
  public let totalPages: Int
  public let totalResults: Int
  
  enum CodingKeys: String, CodingKey {
    case page, results
    case totalPages = "total_pages"
    case totalResults = "total_results"
  }
}

public struct MovieDTO: Decodable {
  public let id: Int
  public let title: String
  public let releaseDate: String?
  public let overview: String?
  public let posterPath: String?
  public let backdropPath: String?
  public let voteAverage: Double?
  
  enum CodingKeys: String, CodingKey {
    case id, title, overview
    case releaseDate = "release_date"
    case posterPath = "poster_path"
    case backdropPath = "backdrop_path"
    case voteAverage = "vote_average"
  }
  
  public func toDomain() -> Movie {
    return Movie(
      id: id,
      title: title,
      releaseDate: releaseDate ?? "Unknown",
      overview: overview ?? "",
      posterPath: posterPath,
      backdropPath: backdropPath,
      voteAverage: voteAverage ?? 0.0
    )
  }
}

public struct GenreDTO: Decodable {
  public let id: Int
  public let name: String
  
  public func toDomain() -> Genre {
    return Genre(id: id, name: name)
  }
}

public struct SpokenLanguageDTO: Decodable {
  public let englishName: String?
  public let name: String?
  
  enum CodingKeys: String, CodingKey {
    case englishName = "english_name"
    case name
  }
  
  public func toDomain() -> SpokenLanguage {
    return SpokenLanguage(name: englishName ?? name ?? "Unknown")
  }
}

public struct ProductionCompanyDTO: Decodable {
  public let id: Int
  public let name: String
  
  public func toDomain() -> ProductionCompany {
    return ProductionCompany(id: id, name: name)
  }
}

public struct MovieDetailDTO: Decodable {
  public let id: Int
  public let title: String
  public let releaseDate: String?
  public let overview: String?
  public let posterPath: String?
  public let backdropPath: String?
  public let voteAverage: Double?
  public let genres: [GenreDTO]?
  public let spokenLanguages: [SpokenLanguageDTO]?
  public let productionCompanies: [ProductionCompanyDTO]?
  
  enum CodingKeys: String, CodingKey {
    case id, title, overview, genres
    case releaseDate = "release_date"
    case posterPath = "poster_path"
    case backdropPath = "backdrop_path"
    case voteAverage = "vote_average"
    case spokenLanguages = "spoken_languages"
    case productionCompanies = "production_companies"
  }
  
  public func toDomain() -> MovieDetail {
    return MovieDetail(
      id: id,
      title: title,
      releaseDate: releaseDate ?? "Unknown",
      overview: overview ?? "",
      posterPath: posterPath,
      backdropPath: backdropPath,
      voteAverage: voteAverage ?? 0.0,
      genres: genres?.map { $0.toDomain() } ?? [],
      spokenLanguages: spokenLanguages?.map { $0.toDomain() } ?? [],
      productionCompanies: productionCompanies?.map { $0.toDomain() } ?? []
    )
  }
}
