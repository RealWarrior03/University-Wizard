//
//  SetWebsites.swift
//  TU Berlin (iOS)
//
//  Created by Henry Krieger on 01.12.21.
//

import SwiftUI

struct SetWebsites: View {
    @State var websiteOne: String = ""
    @State var websiteOneURL: String = ""
    @State var websiteTwo: String = ""
    @State var websiteTwoURL: String = ""
    @State var websiteThree: String = ""
    @State var websiteThreeURL: String = ""
    
    var body: some View {
        ZStack {
            Color(UIColor(.secondary)).opacity(0.2).ignoresSafeArea()
            ScrollView {
                VStack {
                    
                    Text("Coming in a future version")
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 15, style: .continuous).fill(Material.regular)
                        VStack(alignment: .leading) {
                            Text("Website One").font(.callout).foregroundColor(.secondary)
                            TextField("Name", text: $websiteOne).textFieldStyle(.roundedBorder)
                            TextField("URL", text: $websiteOneURL).textFieldStyle(.roundedBorder)
                        }.padding()
                    }
                    ZStack {
                        RoundedRectangle(cornerRadius: 15, style: .continuous).fill(Material.regular)
                        VStack(alignment: .leading) {
                            Text("Website Two").font(.callout).foregroundColor(.secondary)
                            TextField("Name", text: $websiteTwo).textFieldStyle(.roundedBorder)
                            TextField("URL", text: $websiteTwoURL).textFieldStyle(.roundedBorder)
                        }.padding()
                    }
                    ZStack {
                        RoundedRectangle(cornerRadius: 15, style: .continuous).fill(Material.regular)
                        VStack(alignment: .leading) {
                            Text("Website Three").font(.callout).foregroundColor(.secondary)
                            TextField("Name", text: $websiteThree).textFieldStyle(.roundedBorder)
                            TextField("URL", text: $websiteThreeURL).textFieldStyle(.roundedBorder)
                        }.padding()
                    }
                }.padding()
            }.navigationTitle("Set Websites")
        }
    }
}

struct SetWebsites_Previews: PreviewProvider {
    static var previews: some View {
        SetWebsites()
    }
}
