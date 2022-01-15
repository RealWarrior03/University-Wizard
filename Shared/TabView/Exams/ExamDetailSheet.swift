//
//  ExamDetailSheet.swift
//  TU Berlin (iOS)
//
//  Created by Henry Krieger on 15.01.22.
//

import SwiftUI

struct ExamDetailSheet: View {
    var examData: FetchedResults<Exam>.Element
    
    static let examDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .short
        return formatter
    }()
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Due")) {
                    Text("\(examData.due, formatter: ExamDetailSheet.examDateFormatter)")
                }
                
                Section(header: Text("Class")) {
                    Text("\(examData.subject)")
                }
                
                Section(header: Text("Comment")) {
                    Text("\(examData.comment)")
                }
            }
            .navigationTitle(examData.title)
            .overlay {
                VStack {
                    Spacer()
                    HStack {
                        Button {
                            
                        } label: {
                            Image(systemName: "checkmark")
                                .frame(maxWidth: .infinity, minHeight: 25)
                        }.buttonStyle(.borderedProminent).disabled(true)
                        Menu {
                            Section {
                                Button {
                                    /*hwIndex = hw
                                    deleteAlert.toggle()*/
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }.disabled(true)
                                Button {
                                    /*homework[hw].done.toggle()
                                    hwIndex = hw
                                    self.delete(at: hwIndex)
                                    try! viewContext.save()*/
                                } label: {
                                    Label("Complete", systemImage: "checkmark")
                                }.disabled(true)
                            }
                            Section {
                                Button {
                                    
                                } label: {
                                    Label("Edit", systemImage: "rectangle.and.pencil.and.ellipsis")
                                }.disabled(true)
                                Button {
                                    
                                } label: {
                                    Label("Share", systemImage: "square.and.arrow.up")
                                }.disabled(true)
                            }
                        } label: {
                            Button {
                                //none
                            } label: {
                                Image(systemName: "ellipsis")
                                    .frame(maxWidth: .infinity, minHeight: 25)
                            }.buttonStyle(.borderedProminent)
                        }
                    }
                }.padding()
            }
        }
    }
}
