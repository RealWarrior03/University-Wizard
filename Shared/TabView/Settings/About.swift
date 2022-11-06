//
//  About.swift
//  TU Berlin (iOS)
//
//  Created by Henry Krieger on 15.01.22.
//

import SwiftUI
import MessageUI

enum Sheets {
    case twitter
    case ppGer
    case ppEng
}

struct About: View {
    @State var showSafari: Bool = false
        
    @State var result: Result<MFMailComposeResult, Error>? = nil
    @State var showMailView: Bool = false
    
    @State var sheets: Sheets = .twitter
        
    var body: some View {
        List {
            Section {
                HStack {
                    Image("AboutIcon")
                        .resizable()
                        .frame(width: 100, height: 100, alignment: .center)
                    VStack(alignment: .leading) {
                        Text("FROM")
                            .font(.callout)
                            .foregroundColor(.gray)
                            .fontWeight(.bold)
                            .padding(.bottom, 2)
                        Text("Henry Krieger")
                            .font(.title2)
                            .fontWeight(.bold)
                    }.padding()
                }
            }
            
            Section {
                /*Button(action: { showSafari.toggle() }) {
                 Label("Open Website", systemImage: "safari")
                 }.sheet(isPresented: $showSafari) {
                 SafariView(url: URL(string: "https://bio.link/hkrieger")!)
                 }*/
                Button(action: {
                    sheets = .twitter
                    showSafari.toggle()
                }) {
                    Label("Twitter", systemImage: "safari")
                }/*.sheet(isPresented: $showSafari) {
                    SafariView(url: URL(string: "https://twitter.com/_hkrieger_")!)
                }*/
                
                Button(action: {
                    showMailView.toggle()
                }) {
                    Label("Send Feedback", systemImage: "envelope")
                }.disabled(!MFMailComposeViewController.canSendMail())
                .sheet(isPresented: $showMailView) {
                    MailView(result: self.$result)
                }
                
                NavigationLink(destination: CreditsAndLegal()) {
                    Label("Credits and Legal", systemImage: "scroll")
                }
                
                Button(action: {
                    sheets = .ppEng
                    showSafari.toggle()
                }) {
                    Label("Privacy Policy (EN)", systemImage: "hand.raised")
                }/*.sheet(isPresented: $showSafari) {
                    SafariView(url: URL(string: "https://mini-cushion-bac.notion.site/Privacy-Policy-dc02cbc2a566412fadbd1d038d5c75de")!)
                }*/
                
                Button(action: {
                    sheets = .ppGer
                    showSafari.toggle()
                }) {
                    Label("Privacy Policy (DE)", systemImage: "hand.raised")
                }/*.sheet(isPresented: $showSafari) {
                    SafariView(url: URL(string: "https://mini-cushion-bac.notion.site/Datenschutzerkl-rung-74c0697b92b6496ebead00e10e524fc3")!)
                }*/
            }
            .sheet(isPresented: $showSafari) {
                switch sheets {
                case .twitter:
                    SafariView(url: URL(string: "https://twitter.com/_hkrieger_")!)
                case .ppEng:
                    SafariView(url: URL(string: "https://mini-cushion-bac.notion.site/Privacy-Policy-dc02cbc2a566412fadbd1d038d5c75de")!)
                case .ppGer:
                    SafariView(url: URL(string: "https://mini-cushion-bac.notion.site/Datenschutzerkl-rung-74c0697b92b6496ebead00e10e524fc3")!)
                }
            }
        }
        .listStyle(.insetGrouped)
        .navigationTitle("About us")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct About_Previews: PreviewProvider {
    static var previews: some View {
        About()
    }
}
