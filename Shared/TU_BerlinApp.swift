//
//  TU_BerlinApp.swift
//  Shared
//
//  Created by Henry Krieger on 11.11.21.
//

import SwiftUI

@main
struct TU_BerlinApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
