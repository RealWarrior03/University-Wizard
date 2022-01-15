//
//  CustomTabView.swift
//  TU Berlin (iOS)
//
//  Created by Henry Krieger on 13.11.21.
//

import SwiftUI

struct CustomTabView: View {
    public var cornerRadius: Double = 15
    let viewRouter: ViewRouter
    
    @State var widthDivider: Int = 5 // bei allen items: 6
    @State var heigthDivider: Int = 28
    
    @State var colorHome: Color = .accentColor.opacity(1.0)
    @State var colorHW: Color = .accentColor.opacity(0.3)
    @State var colorEX: Color = .accentColor.opacity(0.3)
    @State var colorKC: Color = .accentColor.opacity(0.3)
    @State var colorTM: Color = .accentColor.opacity(0.3)
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .fill(.thickMaterial)//.opacity(0.1)
                HStack {
                    CustomTabItem(icon: "house", text: "Home", color: self.colorHome, width: geo.size.width/CGFloat(widthDivider), height: geo.size.height/CGFloat(heigthDivider), viewRouter: viewRouter, assignedPage: .home, colorHome: $colorHome, colorHW: $colorHW, colorEX: $colorEX, colorKC: $colorKC, colorTM: $colorTM)
                    CustomTabItem(icon: "checkmark.square", text: "Homework", color: self.colorHW, width: geo.size.width/CGFloat(widthDivider), height: geo.size.height/CGFloat(heigthDivider), viewRouter: viewRouter, assignedPage: .homework, colorHome: $colorHome, colorHW: $colorHW, colorEX: $colorEX, colorKC: $colorKC, colorTM: $colorTM)
                    CustomTabItem(icon: "pencil", text: "Exams", color: self.colorEX, width: geo.size.width/CGFloat(widthDivider), height: geo.size.height/CGFloat(heigthDivider), viewRouter: viewRouter, assignedPage: .exams, colorHome: $colorHome, colorHW: $colorHW, colorEX: $colorEX, colorKC: $colorKC, colorTM: $colorTM)
                    /*CustomTabItem(icon: "note", text: "Key Cards", color: self.colorKC, width: geo.size.width/CGFloat(widthDivider), height: geo.size.height/CGFloat(heigthDivider), viewRouter: viewRouter, assignedPage: .keycards, colorHome: $colorHome, colorHW: $colorHW, colorEX: $colorEX, colorKC: $colorKC, colorTM: $colorTM)*/
                    /*CustomTabItem(icon: "clock", text: "Timer", color: self.colorTM, width: geo.size.width/CGFloat(widthDivider), height: geo.size.height/CGFloat(heigthDivider), viewRouter: viewRouter, assignedPage: .timer, colorHome: $colorHome, colorHW: $colorHW, colorEX: $colorEX, colorKC: $colorKC, colorTM: $colorTM)*/
                }
            }
        }
    }
}

struct CustomTabView_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabView(viewRouter: ViewRouter())
    }
}
