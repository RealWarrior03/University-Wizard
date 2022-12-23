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
    
    @Published var defaultDueTime: Date {
        didSet {
            UserDefaults.standard.set(defaultDueTime, forKey: "defaultDueTime")
        }
    }
    @Published var defaultExamTime: Date {
        didSet {
            UserDefaults.standard.set(defaultExamTime, forKey: "defaultExamTime")
        }
    }
    @Published var highlightDue: Bool {
        didSet {
            UserDefaults.standard.set(highlightDue, forKey: "highlightDue")
        }
    }
    
    @Published var websiteOneURL: String {
        didSet {
            UserDefaults.standard.set(websiteOneURL, forKey: "websiteOneURL")
        }
    }
    @Published var websiteOneTitle: String {
        didSet {
            UserDefaults.standard.set(websiteOneTitle, forKey: "websiteOneTitle")
        }
    }
    @Published var websiteTwoURL: String {
        didSet {
            UserDefaults.standard.set(websiteTwoURL, forKey: "websiteTwoURL")
        }
    }
    @Published var websiteTwoTitle: String {
        didSet {
            UserDefaults.standard.set(websiteTwoTitle, forKey: "websiteTwoTitle")
        }
    }
    @Published var websiteThreeURL: String {
        didSet {
            UserDefaults.standard.set(websiteThreeURL, forKey: "websiteThreeURL")
        }
    }
    @Published var websiteThreeTitle: String {
        didSet {
            UserDefaults.standard.set(websiteThreeTitle, forKey: "websiteThreeTitle")
        }
    }
    
    @Published var allowNotifications: Bool {
        didSet {
            UserDefaults.standard.set(allowNotifications, forKey: "allowNotifications")
        }
    }
    
    init() {
        self.colorHome = UserDefaults.standard.object(forKey: "colorHome") as? Color ?? .accentColor.opacity(1.0)
        self.colorHW = UserDefaults.standard.object(forKey: "colorHW") as? Color ?? .accentColor.opacity(0.3)
        self.colorEX = UserDefaults.standard.object(forKey: "colorEX") as? Color ?? .accentColor.opacity(0.3)
        self.colorTM = UserDefaults.standard.object(forKey: "colorTM") as? Color ?? .accentColor.opacity(0.3)
        
        self.defaultDueTime = UserDefaults.standard.object(forKey: "defaultDueTime") as? Date ?? Date()
        self.defaultExamTime = UserDefaults.standard.object(forKey: "defaultExamTime") as? Date ?? Date()
        self.highlightDue = UserDefaults.standard.object(forKey: "highlightDue") as? Bool ?? true
        
        self.websiteOneURL = UserDefaults.standard.object(forKey: "websiteOneURL") as? String ?? ""
        self.websiteOneTitle = UserDefaults.standard.object(forKey: "websiteOneTitle") as? String ?? ""
        self.websiteTwoURL = UserDefaults.standard.object(forKey: "websiteTwoURL") as? String ?? ""
        self.websiteTwoTitle = UserDefaults.standard.object(forKey: "websiteTwoTitle") as? String ?? ""
        self.websiteThreeURL = UserDefaults.standard.object(forKey: "websiteThreeURL") as? String ?? ""
        self.websiteThreeTitle = UserDefaults.standard.object(forKey: "websiteThreeTitle") as? String ?? ""
        
        self.allowNotifications = UserDefaults.standard.object(forKey: "allowNotifications") as? Bool ?? false
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
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
