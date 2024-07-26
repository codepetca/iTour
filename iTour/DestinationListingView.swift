//
//  DestinationListingView.swift
//  iTour
//
//  Created by Stewart Chan on 2024-07-25.
//

import SwiftData
import SwiftUI

struct DestinationListingView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: [
        SortDescriptor(\Destination.priority), SortDescriptor(\Destination.name, order: .reverse),
    ]) var destinations: [Destination]

    init(sort: [SortDescriptor<Destination>], searchString: String) {
        _destinations = Query(
            filter: #Predicate {
                if searchString.isEmpty {
                    return true
                } else {
                    return $0.name.localizedStandardContains(searchString)
                }
            }, sort: sort)
    }

    var body: some View {
        List {
            ForEach(destinations) { destination in
                NavigationLink(value: destination) {
                    VStack(alignment: .leading) {
                        Text(destination.name)
                            .font(.headline)
                        Text(destination.date.formatted(date: .long, time: .shortened))
                    }
                }
            }
            .onDelete(perform: deleteDestinations)
        }
    }

    func deleteDestinations(_ indexSet: IndexSet) {
        for index in indexSet {
            let destination = destinations[index]
            modelContext.delete(destination)
        }
    }
}

#Preview {
    DestinationListingView(sort: [SortDescriptor(\Destination.name)], searchString: "")
}
