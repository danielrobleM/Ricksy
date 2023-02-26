//
//  Model.swift
//  Ricksy
//
//  Created by Daniel Roble on 19-02-23.
//

// MARK: - CategoriesResponse
struct CharactersResponse: Codable {
  let info: Info
  let results: [Character]
}

// MARK: - Info
struct Info: Codable {
  let count, pages: Int
  let next: String
  let prev: String?
}

protocol MainDataSource {
  var name: String {get}
}

// MARK: - Result
struct Character: Codable, Hashable, MainDataSource {
  let id: Int
  let name: String
  let status: Status
  let species: Species
  let type: String
  let gender: Gender
  let origin, location: LocationCharacter
  let image: String
  let episode: [String]
  let url: String
  let created: String
  
  static func == (lhs: Character, rhs: Character) -> Bool {
    return lhs.id == rhs.id
  }
  
  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
}

enum Gender: String, Codable {
  case female = "Female"
  case male = "Male"
  case unknown = "unknown"
}

// MARK: - Location
struct LocationCharacter: Codable {
  let name: String
  let url: String
}

enum Species: String, Codable {
  case alien = "Alien"
  case human = "Human"
}

enum Status: String, Codable {
  case alive = "Alive"
  case dead = "Dead"
  case unknown = "unknown"
}

// MARK: - CategoriesResponse
struct LocationResponse: Codable {
  let info: Info
  let results: [Location]
}

// MARK: - Result
struct Location: Codable, Hashable, MainDataSource {
  let id: Int
  let name, type, dimension: String
  let residents: [String]
  let url: String
  let created: String

  static func == (lhs: Location, rhs: Location) -> Bool {
    return lhs.id == rhs.id
  }
  
  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
}

// MARK: - CategoriesResponse
struct EpisodeResponse: Codable {
  let info: Info
  let results: [Episode]
}

// MARK: - Result
struct Episode: Codable, Hashable, MainDataSource {
  let id: Int
  let name, air_date, episode: String
  let characters: [String]
  let url: String
  let created: String

  static func == (lhs: Episode, rhs: Episode) -> Bool {
    return lhs.id == rhs.id
  }
  
  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
}
