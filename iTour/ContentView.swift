//
//  ContentView.swift
//  iTour
//
//  Created by Stewart Chan on 2024-07-25.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @State private var path = [Destination]()
    @State private var searchText = ""
    @State private var sortOrder: [SortDescriptor] = [SortDescriptor(\Destination.name)]
    @State private var onlyFuture: Bool = true

    var body: some View {
        NavigationStack(path: $path) {
            DestinationListingView(sort: sortOrder, searchString: searchText, onlyFuture: onlyFuture)
                .navigationDestination(for: Destination.self, destination: EditDestinationView.init)
                .navigationTitle("iTour")
                .searchable(
                    text: $searchText, placement: .navigationBarDrawer(displayMode: .always)
                )
                .toolbar {
                    Menu("Sort", systemImage: "arrow.up.arrow.down") {
                        Picker("Sort", selection: $sortOrder) {
                            Text("Name")
                                .tag([
                                    SortDescriptor(\Destination.name),
                                    SortDescriptor(\Destination.date),
                                ])
                            Text("Priority")
                                .tag([
                                    SortDescriptor(\Destination.priority, order: .reverse),
                                    SortDescriptor(\Destination.name),
                                ])
                            Text("Date")
                                .tag([
                                    SortDescriptor(\Destination.date),
                                    SortDescriptor(\Destination.name),
                                ])
                        }
                        .pickerStyle(.inline)
                        
                        Picker("Toggle", selection: $onlyFuture){
                            Text("Future Trips")
                                .tag(true)
                            Text("All Trips")
                                .tag(false)
                        }

                    }

                    Button("Add Destination", systemImage: "plus", action: addDestination)
                }
        }

    }

    func addSamples() {
        let rome = Destination(name: "Rome")
        let florence = Destination(name: "Florence")
        let naples = Destination(name: "Naples")

        modelContext.insert(rome)
        modelContext.insert(florence)
        modelContext.insert(naples)
    }

    func addDestination() {
        let destination = Destination()
        modelContext.insert(destination)
        path = [destination]
    }
}

#Preview {
    ContentView()
}
