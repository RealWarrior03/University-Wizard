//
//  Settings.swift
//  TU Berlin (iOS)
//
//  Created by Henry Krieger on 11.11.21.
//

import SwiftUI

struct Settings: View {
    @State var dueTime: Date = Date()
    @State var showDue: Bool = true
    
    var body: some View {
        ZStack {
            Color(UIColor(.secondary)).opacity(0.2).ignoresSafeArea()
            ScrollView {
                VStack {
                    VStack(alignment: .leading) {
                        Text("General").font(.caption).foregroundColor(.secondary).textCase(.uppercase).padding(.leading, 10)
                        ZStack {
                            RoundedRectangle(cornerRadius: 15, style: .continuous).fill(Material.thin)
                            VStack(alignment: .leading) {
                                Text("soon")
                            }.padding()
                        }
                    }.padding(.bottom, 20)
                    
                    VStack(alignment: .leading) {
                        Text("Customize").font(.caption).foregroundColor(.secondary).textCase(.uppercase).padding(.leading, 10)
                        ZStack {
                            RoundedRectangle(cornerRadius: 15, style: .continuous).fill(Material.thin)
                            VStack(alignment: .leading) {
                                CustomNavLink(icon: "app.dashed", text: "App Icon", target: AnyView(Text("coming soon")))
                                CustomNavLink(icon: "paintpalette.fill", text: "Accent Color", target: AnyView(Text("coming soon")))
                            }.padding()
                        }
                    }.padding(.bottom, 20)
                    
                    VStack(alignment: .leading) {
                        Text("University").font(.caption).foregroundColor(.secondary).textCase(.uppercase).padding(.leading, 10)
                        ZStack {
                            RoundedRectangle(cornerRadius: 15, style: .continuous).fill(Material.thin)
                            VStack(alignment: .leading) {
                                DatePicker("Default Due", selection: $dueTime, displayedComponents: .hourAndMinute)
                                Toggle("Highlight Due within 24hrs", isOn: $showDue)
                            }.padding()
                        }
                    }.padding(.bottom, 20)
                    
                    VStack(alignment: .leading) {
                        Text("Resources").font(.caption).foregroundColor(.secondary).textCase(.uppercase).padding(.leading, 10)
                        ZStack {
                            RoundedRectangle(cornerRadius: 15, style: .continuous).fill(Material.thin)
                            VStack(alignment: .leading) {
                                CustomNavLink(icon: "clock", text: "Add Subject", target: AnyView(AddSubjects()))
                                CustomNavLink(icon: "link", text: "Set Websites", target: AnyView(SetWebsites()))
                            }.padding()
                        }
                    }.padding(.bottom, 20)
                    
                    VStack(alignment: .leading) {
                        Text("Other").font(.caption).foregroundColor(.secondary).textCase(.uppercase).padding(.leading, 10)
                        ZStack {
                            RoundedRectangle(cornerRadius: 15, style: .continuous).fill(Material.thin)
                            VStack(alignment: .leading) {
                                CustomNavLink(icon: "star.fill", text: "Leave a Review", target: AnyView(Text("coming soon")))
                                CustomNavLink(icon: "questionmark.circle.fill", text: "Feedback & Help", target: AnyView(Text("coming soon")))
                                CustomNavLink(icon: "banknote.fill", text: "Tip Jar", target: AnyView(Text("coming soon")))
                                CustomNavLink(icon: "i.circle.fill", text: "About", target: AnyView(Text("coming soon")))
                            }.padding()
                        }
                    }.padding(.bottom, 20)
                    
                    VStack(alignment: .leading) {
                        Text("Danger Zone").font(.caption).foregroundColor(.secondary).textCase(.uppercase).padding(.leading, 10)
                        ZStack {
                            RoundedRectangle(cornerRadius: 15, style: .continuous).fill(Material.thin)
                            VStack(alignment: .center) {
                                Button {
                                    
                                } label: {
                                    Label("Delete all homework", systemImage: "trash.fill")
                                }.buttonStyle(.bordered)
                                
                                Button {
                                    
                                } label: {
                                    Label("Delete all exams", systemImage: "trash.fill")
                                }.buttonStyle(.bordered).disabled(true)
                                
                                Button {
                                    
                                } label: {
                                    Label("Delete all key cards", systemImage: "trash.fill")
                                }.buttonStyle(.bordered).disabled(true)
                                
                                Button {
                                    
                                } label: {
                                    Label("Reset everything", systemImage: "exclamationmark.octagon.fill")
                                }.buttonStyle(.bordered)
                            }.padding()
                        }
                    }.padding(.bottom, 30)
                }.padding()
            }
            .navigationTitle("Settings")
            .padding(.bottom, 75)
        }
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
