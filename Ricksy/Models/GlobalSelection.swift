//
//  GlobalSelection.swift
//  Ricksy
//
//  Created by Daniel Roble on 26-02-23.
//

import SwiftUI

class EnvironmentSelection: ObservableObject {
  @Published var character: Character?
  @Published var location: Location?
  @Published var episode: Episode?
}
