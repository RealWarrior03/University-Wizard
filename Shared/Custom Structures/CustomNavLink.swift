//
//  CustomNavLink.swift
//  TU Berlin (iOS)
//
//  Created by Henry Krieger on 12.11.21.
//

import SwiftUI

struct CustomNavLink: View {
    let icon, text: String
    let chevron: String = "chevron.right"
    let target: AnyView
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .fill(Material.regular)
            VStack {
                NavigationLink {
                    target
                } label: {
                    HStack {
                        Label(text, systemImage: icon).frame(width: nil, height: 25)
                        Spacer()
                        Image(systemName: chevron)
                            .foregroundColor(.secondary)
                    }
                }
            }.padding()
        }
    }
}
