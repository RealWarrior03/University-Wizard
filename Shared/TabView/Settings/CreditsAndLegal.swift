//
//  CreditsAndLegal.swift
//  TU Berlin (iOS)
//
//  Created by Henry Krieger on 22.03.22.
//

import SwiftUI

struct CreditsAndLegal: View {
    @State var state: String = "Credits"
    
    let credits = [
        ["School Assistant", "Thanks to Dylan McDonald for creating School Assistant, the app was a huge inspiration for University Wizard. Go download School Assistant!", "https://apps.apple.com/de/app/school-assistant-planner/id1465687472?l=en"]
    ]
    
    let legal = [
        ["SF Symbols 4", "https://developer.apple.com/sf-symbols/"]
    ]
    
    var body: some View {
        List {
            Picker("", selection: $state) {
                Text("Credits").tag("Credits")
                Text("Legal").tag("Legal")
            }.pickerStyle(.segmented)
            
            Section {
                if self.state == "Credits" {
                    ForEach(credits.indices, id: \.self) { index in
                        VStack(alignment: .leading) {
                            HStack {
                                Text("\(credits[index][0])").bold().font(.title)
                                Spacer()
                                if credits[index][2] != "" {
                                    Link(destination: URL(string: credits[index][2])!) {
                                        Text("Link")
                                    }
                                }
                            }
                            Text("\(credits[index][1])")
                        }
                    }
                }
                if self.state == "Legal" {
                    ForEach(legal.indices, id: \.self) { index in
                        VStack(alignment: .leading) {
                            HStack {
                                Text("\(legal[index][0])").bold().font(.title)
                                Spacer()
                                if legal[index][1].contains("https") {
                                    Link(destination: URL(string: legal[index][1])!) {
                                        Text("Link")
                                    }
                                }
                            }
                            if !legal[index][1].contains("https") {
                                Text("\(legal[index][1])")
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle("Credits and Legal")
    }
}

struct CreditsAndLegal_Previews: PreviewProvider {
    static var previews: some View {
        CreditsAndLegal()
    }
}
