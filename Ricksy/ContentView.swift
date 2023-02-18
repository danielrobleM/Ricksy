//
//  ContentView.swift
//  Ricksy
//
//  Created by Daniel Roble on 05-02-23.
//

import SwiftUI

struct Resource: Hashable {
  let name: String
}

struct ContentView: View {
  let resources: [Resource] = [Resource(name: "Character"),
                                Resource(name: "Location"),
                                Resource(name: "Episode")]

  @State private var selection: Resource? = nil

  var body: some View {
    NavigationSplitView {
      List(resources, id: \.self, selection: $selection) { resource in
        NavigationLink(resource.name, value: resource)
      }.onAppear {
        self.selection = resources.first!
      }
    } content: {
      HomeView(title: selection?.name ?? "")
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

struct HomeView: View {
  let title: String
  var resource: String = "Select one please"
  var body: some View {
    Text(resource).navigationTitle(title)
  }
}

struct DetailView: View {
  var resource: String = "Select one please"
  var body: some View {
    Text(resource)
  }
}

/*
struct DemoNavigationStack: View {
  let resources: [Resource] = [Resource(name: "Character"),
                                Resource(name: "Location"),
                                Resource(name: "Episode")]

  var body: some View {
    NavigationStack {
      List {
        Section("Resources") {
          ForEach(resources, id: \.self) { resource in
            NavigationLink(value: resource) {
              Label(resource.name, image: "")
            }
          }
        }
        Section("Favorites") {
          Label("To define", image: "")
        }
      }
      .listStyle(SidebarListStyle())
      //.navigationTitle("Rick And Morty API")
      .navigationDestination(for: Resource.self) { resource in
        DetailView(resource: resource.name)
      }
    }
  }
}
*/
