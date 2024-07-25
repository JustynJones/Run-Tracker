//
//  Run_TrackerApp.swift
//  Run Tracker
//
//  Created by Justyn Jones on 7/25/24.
//

import SwiftUI

@main
struct Run_TrackerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
