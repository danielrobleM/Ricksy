//
//  CharacterRowView.swift
//  Ricksy
//
//  Created by Daniel Roble on 19-02-23.
//

import SwiftUI

struct CharacterRowView: View {
  let character: Character

  var body: some View {
    HStack(alignment: .top, spacing: 10) {
      AsyncImage(
        url: URL(string: character.image)!,
        content: { image in
          image
            .resizable()
            .cornerRadius(15)
        },
        placeholder: {
          ProgressView()
        }
      )
        .frame(width: 150, height: 150)
      VStack(alignment: .leading) {
        Text(character.name)
          .font(.headline)
          .foregroundColor(Color.primary)
          .padding(.bottom, 5)
        HStack(alignment: .center) {
          Circle()
            .fill(getCircleColor(status: character.status))
            .frame(width: 10, height: 10)
          Text("\(character.status.rawValue) - \(character.species.rawValue)")
            .font(.subheadline)
            .foregroundColor(Color.accentColor)
        }
        .padding(.bottom, 5)
        Text("Last known location:")
          .font(.callout)
          .foregroundColor(Color.secondary)
        Text("\(character.location.name)")
          .font(.subheadline)
          .foregroundColor(Color.primary)
          .padding(.bottom, 2)
        Text("First seen in::")
          .font(.callout)
          .foregroundColor(Color.secondary)
        Text("\(character.origin.name)")
          .font(.subheadline)
          .foregroundColor(Color.primary)
          .padding(.bottom, 2)
        //Spacer()
      }
      Spacer()
    }
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

struct CharacterRowView_Previews: PreviewProvider {
  static var previews: some View {
    CharacterRowView(character: Character(id: 0, name: "Rick Sanchez", status: Status.alive, species: .human, type: "", gender: .male, origin: LocationCharacter(name: "Earth (C-137)", url: "ttps://rickandmortyapi.com/api/location/1"), location: LocationCharacter(name: "Citadel of Ricks", url: "https://rickandmortyapi.com/api/location/3"), image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg", episode: [], url: "https://rickandmortyapi.com/api/character/1", created: "2017-11-04T18:48:46.250Z"))
  }
}
