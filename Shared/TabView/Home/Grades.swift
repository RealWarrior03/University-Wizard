//
//  Grades.swift
//  TU Berlin (iOS)
//
//  Created by Henry Krieger on 13.11.21.
//

import SwiftUI

struct Grades: View {
    var body: some View {
        //NavigationView {
            ZStack {
                Color(UIColor(.secondary)).opacity(0.2).ignoresSafeArea()
                ScrollView {
                    VStack {
                        Text("coming soon")
                    }.padding()
                }
                .navigationTitle("Grades")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            
                        } label: {
                            Image(systemName: "plus")
                        }.disabled(true)
                    }
                }
            }
        //}
    }
}

struct Grades_Previews: PreviewProvider {
    static var previews: some View {
        Grades()
    }
}
