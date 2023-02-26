//
//  ContentView.swift
//  Ricksy
//
//  Created by Daniel Roble on 05-02-23.
//

import SwiftUI

enum ResourceType: CaseIterable {
  case character, location, episode

  var name: String {
    switch self {
    case .character:
      return "Character"
    case .location:
      return "Location"
    case .episode:
      return "Episode"
    }
  }

  var endpoint: String {
    switch self {
    case .character:
      return "https://rickandmortyapi.com/api/character"
    case .location:
      return "https://rickandmortyapi.com/api/location"
    case .episode:
      return "https://rickandmortyapi.com/api/episode"
    }
  }

  var decodable: Decodable.Type {
    switch self {
    case .character:
      return CharactersResponse.self
    case .location:
      return LocationResponse.self
    case .episode:
      return EpisodeResponse.self
    }
  }

  var decodable2: String {
    switch self {
    case .character:
      return "CharactersResponse"
    case .location:
      return "LocationResponse"
    case .episode:
      return "EpisodeResponse"
    }
  }
}

struct Resource: Hashable {
  let name: String
}

struct ContentView: View {
  let resourcesOptions: [ResourceType] = ResourceType.allCases

  @State private var selection: ResourceType? = nil
  @State private var columnVisibility = NavigationSplitViewVisibility.all

  var body: some View {
    NavigationSplitView(columnVisibility: $columnVisibility) {
      List(resourcesOptions, id: \.self, selection: $selection) { resource in
        NavigationLink(resource.name, value: resource)
      }.onAppear {
        self.selection = resourcesOptions.first!
        self.columnVisibility = .all
      }
    } content: {
      MainView(resourceType: selection ?? .character)
        .frame(minWidth: 400)
    } detail: {
      DetailView()
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView().previewInterfaceOrientation(.landscapeLeft)
  }
}
