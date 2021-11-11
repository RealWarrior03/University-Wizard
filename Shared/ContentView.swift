//
//  ContentView.swift
//  Shared
//
//  Created by Henry Krieger on 11.11.21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    @StateObject var viewRouter: ViewRouter

    var body: some View {
        Tabs(viewRouter: viewRouter)
    }
}

class UserData: ObservableObject {
    @Published var colorHome: Color {
        didSet {
            UserDefaults.standard.set(colorHome, forKey: "colorHome")
        }
    }
    @Published var colorHW: Color {
        didSet {
            UserDefaults.standard.set(colorHW, forKey: "colorHW")
        }
    }
    @Published var colorEX: Color {
        didSet {
            UserDefaults.standard.set(colorEX, forKey: "colorEX")
        }
    }
    @Published var colorTM: Color {
        didSet {
            UserDefaults.standard.set(colorTM, forKey: "colorTM")
        }
    }
    
    init() {
        self.colorHome = UserDefaults.standard.object(forKey: "colorHome") as? Color ?? .accentColor.opacity(1.0)
        self.colorHW = UserDefaults.standard.object(forKey: "colorHW") as? Color ?? .accentColor.opacity(0.3)
        self.colorEX = UserDefaults.standard.object(forKey: "colorEX") as? Color ?? .accentColor.opacity(0.3)
        self.colorTM = UserDefaults.standard.object(forKey: "colorTM") as? Color ?? .accentColor.opacity(0.3)
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewRouter: ViewRouter()).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
