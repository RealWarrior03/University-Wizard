//
//  Tabs.swift
//  TU Berlin (iOS)
//
//  Created by Henry Krieger on 11.11.21.
//

import SwiftUI

struct Tabs: View {
    @StateObject var viewRouter: ViewRouter
    @State var userData = UserData()
    
    
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                switch viewRouter.currentPage {
                case .home:
                    Home()
                case .homework:
                    Homework()
                case .exams:
                    Exams()
                case .timer:
                    Timer()
                }
            }.overlay {
                VStack {
                    Spacer()
                    ZStack {
                        CustomTabView(viewRouter: self.viewRouter)
                            .frame(width: geometry.size.width-20, height: geometry.size.height/8)
                    }
                }
            }
        }
    }
}

struct CustomTabView: View {
    public var cornerRadius: Double = 15
    let viewRouter: ViewRouter
    
    @State var colorHome: Color = .accentColor.opacity(1.0)
    @State var colorHW: Color = .accentColor.opacity(0.3)
    @State var colorEX: Color = .accentColor.opacity(0.3)
    @State var colorTM: Color = .accentColor.opacity(0.3)
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .fill(.secondary).opacity(0.1)
                HStack {
                    CustomTabItem(icon: "house", text: "Home", color: self.colorHome, width: geo.size.width/5, height: geo.size.height/28, viewRouter: viewRouter, assignedPage: .home, colorHome: $colorHome, colorHW: $colorHW, colorEX: $colorEX, colorTM: $colorTM)
                    CustomTabItem(icon: "checkmark.square", text: "Homework", color: self.colorHW, width: geo.size.width/5, height: geo.size.height/28, viewRouter: viewRouter, assignedPage: .homework, colorHome: $colorHome, colorHW: $colorHW, colorEX: $colorEX, colorTM: $colorTM)
                    CustomTabItem(icon: "pencil", text: "Exams", color: self.colorEX, width: geo.size.width/5, height: geo.size.height/28, viewRouter: viewRouter, assignedPage: .exams, colorHome: $colorHome, colorHW: $colorHW, colorEX: $colorEX, colorTM: $colorTM)
                    CustomTabItem(icon: "clock", text: "Timer", color: self.colorTM, width: geo.size.width/5, height: geo.size.height/28, viewRouter: viewRouter, assignedPage: .timer, colorHome: $colorHome, colorHW: $colorHW, colorEX: $colorEX, colorTM: $colorTM)
                }
            }
        }
    }
}

struct CustomTabItem: View {
    let icon, text: String
    let color: Color
    let width, height: CGFloat
    
    @StateObject var viewRouter: ViewRouter
    let assignedPage: Page
    
    @Binding var colorHome: Color
    @Binding var colorHW: Color
    @Binding var colorEX: Color
    @Binding var colorTM: Color
    
    var body: some View {
        VStack {
            Image(systemName: icon)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(color)
                .frame(width: 25, height: 25)
                .padding(.top, 10)
            Text(text)
                .font(.footnote).padding(.bottom, 10).foregroundColor(color)
            Spacer()
        }.padding(.horizontal, -4).frame(width: width, height: height)
        .onTapGesture {
            viewRouter.currentPage = assignedPage
            if viewRouter.currentPage == .home {
                colorHome = .accentColor.opacity(1.0)
                colorHW = .accentColor.opacity(0.3)
                colorEX = .accentColor.opacity(0.3)
                colorTM = .accentColor.opacity(0.3)
            }
            if viewRouter.currentPage == .homework {
                colorHome = .accentColor.opacity(0.3)
                colorHW = .accentColor.opacity(1.0)
                colorEX = .accentColor.opacity(0.3)
                colorTM = .accentColor.opacity(0.3)
            }
            if viewRouter.currentPage == .exams {
                colorHome = .accentColor.opacity(0.3)
                colorHW = .accentColor.opacity(0.3)
                colorEX = .accentColor.opacity(1.0)
                colorTM = .accentColor.opacity(0.3)
            }
            if viewRouter.currentPage == .timer {
                colorHome = .accentColor.opacity(0.3)
                colorHW = .accentColor.opacity(0.3)
                colorEX = .accentColor.opacity(0.3)
                colorTM = .accentColor.opacity(1.0)
            }
        }
    }
}

struct Tabs_Previews: PreviewProvider {
    static var previews: some View {
        Tabs(viewRouter: ViewRouter())
    }
}
