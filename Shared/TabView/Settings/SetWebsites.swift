//
//  SetWebsites.swift
//  TU Berlin (iOS)
//
//  Created by Henry Krieger on 01.12.21.
//

import SwiftUI

struct SetWebsites: View {
    @State var userData = UserData()
    
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
                    ZStack {
                        RoundedRectangle(cornerRadius: 15, style: .continuous).fill(Material.regular)
                        VStack(alignment: .leading) {
                            Text("Website One")
                                .font(.callout).foregroundColor(.secondary)
                            TextField("Name", text: $userData.websiteOneTitle)
                                .textFieldStyle(.roundedBorder)
                            TextField("URL (https://www. ... .de)", text: $userData.websiteOneURL)
                                .textFieldStyle(.roundedBorder).textInputAutocapitalization(.never).disableAutocorrection(true)
                        }.padding()
                    }
                    ZStack {
                        RoundedRectangle(cornerRadius: 15, style: .continuous).fill(Material.regular)
                        VStack(alignment: .leading) {
                            Text("Website Two").font(.callout).foregroundColor(.secondary)
                            TextField("Name", text: $userData.websiteTwoTitle).textFieldStyle(.roundedBorder)
                            TextField("URL (https://www. ... .de)", text: $userData.websiteTwoURL).textFieldStyle(.roundedBorder).textInputAutocapitalization(.never).disableAutocorrection(true)
                        }.padding()
                    }
                    ZStack {
                        RoundedRectangle(cornerRadius: 15, style: .continuous).fill(Material.regular)
                        VStack(alignment: .leading) {
                            Text("Website Three").font(.callout).foregroundColor(.secondary)
                            TextField("Name", text: $userData.websiteThreeTitle).textFieldStyle(.roundedBorder)
                            TextField("URL (https://www. ... .de)", text: $userData.websiteThreeURL).textFieldStyle(.roundedBorder).textInputAutocapitalization(.never).disableAutocorrection(true)
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
