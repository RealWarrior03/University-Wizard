//
//  Home.swift
//  TU Berlin (iOS)
//
//  Created by Henry Krieger on 11.11.21.
//

import SwiftUI

struct Home: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color(UIColor(.secondary)).opacity(0.2).ignoresSafeArea()
                ScrollView {
                    VStack {
                        CustomNavLink(icon: "link", text: "TU Website", target: AnyView(Text("soon")))
                        CustomNavLink(icon: "link", text: "ISIS", target: AnyView(Text("soon")))
                        CustomNavLink(icon: "link", text: "Moses", target: AnyView(Text("soon")))
                        
                        Divider().padding(.vertical)
                        
                        CustomNavLink(icon: "function", text: "Grades", target: AnyView(Grades()))
                        
                        Divider().padding(.vertical)
                        
                        CustomNavLink(icon: "gear", text: "Settings", target: AnyView(Settings()))
                        
                        /*ForEach(0..<11, id: \.self) { item in
                            CustomNavLink(icon: "\(item).square", text: "item \(item)", target: AnyView(Text("item \(item)")))
                        }*/
                    }.padding().padding(.bottom, 50)
                }.padding(.bottom, 50)
                .navigationTitle("Home")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Menu {
                            Text("Menu Item 1")
                            Text("Menu Item 2")
                        } label: {
                            Image(systemName: "chevron.down")
                        }
                    }
                }
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
