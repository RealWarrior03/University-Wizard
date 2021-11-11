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
    
    @StateObject var viewRouter = ViewRouter()
    var body: some Scene {
        WindowGroup {
            ContentView(viewRouter: viewRouter)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
