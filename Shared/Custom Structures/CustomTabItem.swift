//
//  CustomTabItem.swift
//  TU Berlin (iOS)
//
//  Created by Henry Krieger on 13.11.21.
//

import SwiftUI

struct CustomTabItem: View {
    let icon, text: String
    let color: Color
    let width, height: CGFloat
    
    @StateObject var viewRouter: ViewRouter
    let assignedPage: Page
    
    @Binding var colorHome: Color
    @Binding var colorHW: Color
    @Binding var colorEX: Color
    @Binding var colorKC: Color
    @Binding var colorTM: Color
    
    var body: some View {
        ZStack {
            Circle().opacity(0.00001)
            VStack {
                Image(systemName: icon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(color)
                    .frame(width: 25, height: 25)
                    .padding(.top, 10)
                Text(text)
                    .font(.footnote).padding(.bottom, 0).foregroundColor(color)
                Spacer()
            }.padding(.horizontal, -4).frame(width: width, height: height)
        }
        .onTapGesture {
            viewRouter.currentPage = assignedPage
            if viewRouter.currentPage == .home {
                colorHome = .accentColor.opacity(1.0)
                colorHW = .accentColor.opacity(0.3)
                colorEX = .accentColor.opacity(0.3)
                colorKC = .accentColor.opacity(0.3)
                colorTM = .accentColor.opacity(0.3)
            }
            if viewRouter.currentPage == .homework {
                colorHome = .accentColor.opacity(0.3)
                colorHW = .accentColor.opacity(1.0)
                colorEX = .accentColor.opacity(0.3)
                colorKC = .accentColor.opacity(0.3)
                colorTM = .accentColor.opacity(0.3)
            }
            if viewRouter.currentPage == .exams {
                colorHome = .accentColor.opacity(0.3)
                colorHW = .accentColor.opacity(0.3)
                colorEX = .accentColor.opacity(1.0)
                colorKC = .accentColor.opacity(0.3)
                colorTM = .accentColor.opacity(0.3)
            }
            if viewRouter.currentPage == .keycards {
                colorHome = .accentColor.opacity(0.3)
                colorHW = .accentColor.opacity(0.3)
                colorEX = .accentColor.opacity(0.3)
                colorKC = .accentColor.opacity(1.0)
                colorTM = .accentColor.opacity(0.3)
            }
            if viewRouter.currentPage == .timer {
                colorHome = .accentColor.opacity(0.3)
                colorHW = .accentColor.opacity(0.3)
                colorEX = .accentColor.opacity(0.3)
                colorKC = .accentColor.opacity(0.3)
                colorTM = .accentColor.opacity(1.0)
            }
        }
    }
}
