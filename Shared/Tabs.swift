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
                    HomeworkView()
                case .exams:
                    ExamView()
                case .keycards:
                    KeycardView()
                case .timer:
                    Timer()
                }
            }
            .overlay {
                VStack {
                    Spacer()
                    ZStack {
                        CustomTabView(viewRouter: self.viewRouter)
                            .frame(width: geometry.size.width-20, height: geometry.size.height/8)
                            .padding(.bottom, 10)
                    }
                }
            }
        }
    }
}

struct Tabs_Previews: PreviewProvider {
    static var previews: some View {
        Tabs(viewRouter: ViewRouter())
    }
}
