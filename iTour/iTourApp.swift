//
//  iTourApp.swift
//  iTour
//
//  Created by Stewart Chan on 2024-07-25.
//

import SwiftData
import SwiftUI

@main
struct iTourApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Destination.self)
    }
}
