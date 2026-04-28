//
// Copyright (c) 2026 Coderkube Technologies - SwiftUICleanArchitectureApp. All rights reserved.
//

import Foundation

public struct Movie: Identifiable, Hashable {
  public let id: Int
  public let title: String
  public let releaseDate: String
  public let overview: String
  public let posterPath: String?
  public let backdropPath: String?
  public let voteAverage: Double
  
  public init(id: Int, title: String, releaseDate: String, overview: String, posterPath: String?, backdropPath: String?, voteAverage: Double) {
    self.id = id
    self.title = title
    self.releaseDate = releaseDate
    self.overview = overview
    self.posterPath = posterPath
    self.backdropPath = backdropPath
    self.voteAverage = voteAverage
  }
}

public struct Genre: Identifiable, Hashable {
  public let id: Int
  public let name: String
}

public struct SpokenLanguage: Hashable {
  public let name: String
}

public struct ProductionCompany: Identifiable, Hashable {
  public let id: Int
  public let name: String
}

public struct MovieDetail: Identifiable, Hashable {
  public let id: Int
  public let title: String
  public let releaseDate: String
  public let overview: String
  public let posterPath: String?
  public let backdropPath: String?
  public let voteAverage: Double
  public let genres: [Genre]
  public let spokenLanguages: [SpokenLanguage]
  public let productionCompanies: [ProductionCompany]
  
  public init(id: Int, title: String, releaseDate: String, overview: String, posterPath: String?, backdropPath: String?, voteAverage: Double, genres: [Genre], spokenLanguages: [SpokenLanguage], productionCompanies: [ProductionCompany]) {
    self.id = id
    self.title = title
    self.releaseDate = releaseDate
    self.overview = overview
    self.posterPath = posterPath
    self.backdropPath = backdropPath
    self.voteAverage = voteAverage
    self.genres = genres
    self.spokenLanguages = spokenLanguages
    self.productionCompanies = productionCompanies
  }
}
