//
//  DetailView.swift
//  Ricksy
//
//  Created by Daniel Roble on 26-02-23.
//

import SwiftUI


struct DetailView: View {
  let resourceType: ResourceType
  @EnvironmentObject var selection: EnvironmentSelection

  var body: some View {
    switch resourceType {
    case .character:
      if let character = selection.character {
        VStack(alignment: .center) {
          AsyncImage(
            url: URL(string: character.image)!,
            content: { image in
              image
                .resizable()
                .frame(width: 300, height: 300, alignment: .center)
                .clipShape(Circle())
            },
            placeholder: {
              ProgressView()
            }
          )
          .padding(.bottom, 15)
          Text(character.name)
            .font(.largeTitle)
            .foregroundColor(Color.primary)
            .id(character.name)
            .transition(.opacity.animation(.linear))
          HStack(alignment: .center) {
            Circle()
              .fill(getCircleColor(status: character.status))
              .frame(width: 20, height: 20)
            Text("\(character.status.rawValue) - \(character.species.rawValue)")
              .font(.title)
              .foregroundColor(Color.primary)
          }
          Spacer()
        }.padding(.top, 15)
      } else {
        Text(getText())
      }
    case .location:
      Text(getText())
    case .episode:
      Text(getText())
    }
  }

  private func getText() -> String {
    switch resourceType {
    case .character:
      return getTextCharacter()
    case .location:
      return getTextLocation()
    case .episode:
      return getTextEpisode()
    }
  }

  private func getTextCharacter() -> String {
    guard let character = self.selection.character else {
      return "Loading"
    }
    return "Selected Character: \(character.name)"
  }

  private func getTextLocation() -> String {
    guard let location = self.selection.location else {
      return "Loading"
    }
    return "Selected Character: \(location.name)"
  }

  private func getTextEpisode() -> String {
    guard let episode = self.selection.episode else {
      return "Loading"
    }
    return "Selected Character: \(episode.name)"
  }

  func getCircleColor(status: Status) -> Color {
    switch status {
    case .alive:
      return .green
    case .dead:
      return .red
    case .unknown:
      return .gray
    }
  }
}

struct DetailView_Previews: PreviewProvider {
  static var character = Character(id: 0, name: "Rick Sanchez", status: Status.alive, species: .human, type: "", gender: .male, origin: LocationCharacter(name: "Earth (C-137)", url: "ttps://rickandmortyapi.com/api/location/1"), location: LocationCharacter(name: "Citadel of Ricks", url: "https://rickandmortyapi.com/api/location/3"), image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg", episode: [], url: "https://rickandmortyapi.com/api/character/1", created: "2017-11-04T18:48:46.250Z")
  static var previews: some View {
    DetailView(resourceType: .character)
      .environmentObject({ () -> EnvironmentSelection in
        var environmentSelection = EnvironmentSelection()
        environmentSelection.character = character
        return environmentSelection
        } () )
    }
}
