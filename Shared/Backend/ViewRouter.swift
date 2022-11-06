//
//  ViewRouter.swift
//  TU Berlin (iOS)
//
//  Created by Henry Krieger on 11.11.21.
//

import Foundation
import SwiftUI

class ViewRouter: ObservableObject {
    @Published var currentPage: Page = .home
}

enum Page {
    case home
    case homework
    case exams
    case keycards
    case timer
}
