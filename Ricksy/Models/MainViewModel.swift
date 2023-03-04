//
//  MainViewModel.swift
//  Ricksy
//
//  Created by Daniel Roble on 26-02-23.
//

import SwiftUI
import Combine

class MainViewModel: ObservableObject {
  init(resourceType: ResourceType) {
    self.resourceType  = resourceType
  }

  @EnvironmentObject var selection: EnvironmentSelection

  @Published var resourceType: ResourceType

  private var cancellableBag = Set<AnyCancellable>()

  @Published private(set) var count: Int = 0
  @Published private(set) var isLoading: Bool = true
  @Published private(set) var dataSource: [Character] = []
  @Published private(set) var dataSourceLocation: [Location] = []
  @Published private(set) var dataSourceEpisode: [Episode] = []
  @Published var quotes = [
    "Grass tastes bad.",
    "Don't be a b****, Summer.",
    "I'm not looking for judgement, just a yes or no. Can you assimilate a giraffe?",
    "You're young, you have your whole life ahead of you, and your anal cavity is still taut yet malleable.",
    "Hit the sack, Jack!",
    "Tiny Rick!",
    "Wubba lubba dub dub!",
    "I'm not the nicest guy in the universe because I'm the smartest. And being nice is something stupid people do to hedge their bets.",
    "I'm sorry, Morty. It's a bummer. In reality, you're as dumb as they come.",
    "Pickle Riiiiick!"
  ]

  func getDataSource() -> [Any] {
    switch resourceType {
    case .character:
      return self.dataSource
    case .location:
      return self.dataSourceLocation
    case .episode:
      return self.dataSourceEpisode
    }
  }

  func getLoadingQuotes() -> String {
    return quotes.randomElement() ?? ""
  }

  func fetch() {
    switch resourceType {
    case .character:
      fetchCharacter()
    case .location:
      fetchLocation()
    case .episode:
      fetchEpisode()
    }
  }

  func fetchCharacter() {
    fetch(resourceType: resourceType.self, responseType: CharactersResponse.self) { result in
      switch result {
      case .success(let characters):
        self.dataSource = characters.results
      case .failure: break
      }
    }
  }

  func fetchLocation() {
    fetch(resourceType: resourceType.self, responseType: LocationResponse.self) { result in
      switch result {
      case .success(let characters):
        self.dataSourceLocation = characters.results
      case .failure: break
      }
    }
  }

  func fetchEpisode() {
    fetch(resourceType: resourceType.self, responseType: EpisodeResponse.self) { result in
      switch result {
      case .success(let characters):
        self.dataSourceEpisode = characters.results
      case .failure: break
      }
    }
  }

  func fetch<T: Decodable>(resourceType: ResourceType, responseType: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
    let url = URL(string: resourceType.endpoint)!
    URLSession
      .shared
      .dataTaskPublisher(for: url)
      .receive(on: DispatchQueue.main)
      .map(\.data)
      .decode(type: responseType.self, decoder: JSONDecoder())
      .sink(receiveCompletion: { [weak self] completionResult in
        switch completionResult {
        case .finished:
          self?.isLoading = false
        case .failure(let error):
          print(error.localizedDescription)
          completion(.failure(error))
        }
      }, receiveValue: { response in
        completion(.success(response))
      })
      .store(in: &cancellableBag)
  }
}
