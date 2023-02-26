//
//  MainView.swift
//  Ricksy
//
//  Created by Daniel Roble on 18-02-23.
//

import SwiftUI

struct MainView: View {
  @StateObject var viewModel: MainViewModel

  let resourceType: ResourceType

  init(resourceType: ResourceType) {
    self.resourceType = resourceType
    _viewModel = .init(wrappedValue: MainViewModel(resourceType: resourceType))
  }

  var body: some View {
    Group {
      if viewModel.isLoading {
        VStack {
          ProgressView()
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
          Text(viewModel.getLoadingQuotes())
            .multilineTextAlignment(.center)
            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
        }
      } else {
        switch viewModel.resourceType {
        case .character:
          List(viewModel.dataSource, id: \.self) { character in
            CharacterRowView(character: character)
          }
        case .location:
          List(viewModel.dataSourceLocation, id: \.self) { dataSource in
            Text(dataSource.name)
          }
        case .episode:
          List(viewModel.dataSourceEpisode, id: \.self) { dataSource in
            Text(dataSource.name)
          }
        }
      }
    }
    .navigationTitle(viewModel.resourceType.name)
    .onAppear {
      viewModel.fetch()
    }.onChange(of: resourceType) { newResourceType in
      viewModel.resourceType = newResourceType
      viewModel.fetch()
    }
  }
}

struct MainView_Previews: PreviewProvider {
  static var previews: some View {
    MainView(resourceType: .character)
      .previewInterfaceOrientation(.landscapeLeft)
  }
}
