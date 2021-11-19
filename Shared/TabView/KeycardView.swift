//
//  KeycardView.swift
//  TU Berlin (iOS)
//
//  Created by Henry Krieger on 19.11.21.
//

import SwiftUI

struct KeycardView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color(UIColor(.secondary)).opacity(0.2).ignoresSafeArea()
                ScrollView {
                    VStack {
                        CustomNavLink(icon: "hammer", text: "start quiz", target: AnyView(Text("coming soon")))
                    }.padding()
                }
                .navigationTitle("Key Cards")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                }
            }
        }
    }
}

struct KeycardView_Previews: PreviewProvider {
    static var previews: some View {
        KeycardView()
    }
}
