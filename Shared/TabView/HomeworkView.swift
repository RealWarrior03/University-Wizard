//
//  Homework.swift
//  TU Berlin (iOS)
//
//  Created by Henry Krieger on 11.11.21.
//

import SwiftUI

struct HomeworkView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Homework.due, ascending: true),
            NSSortDescriptor(keyPath: \Homework.title, ascending: true)
        ],
        animation: .default)
    private var homework: FetchedResults<Homework>
    
    @State var addHomework: Bool = false
    @State var deleteAlert: Bool = false
    @State var hwIndex: Int = 0
    
    static let homeworkFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .short
        return formatter
    }()
    
    func delete(at index: Int) {
        self.viewContext.delete(homework[index])
        try! self.viewContext.save()
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(UIColor(.secondary)).opacity(0.2).ignoresSafeArea()
                ScrollView {
                    VStack {
                        ForEach(homework.indices, id: \.self) { hw in
                            ZStack {
                                RoundedRectangle(cornerRadius: 15, style: .continuous).fill(Material.regular)
                                VStack(alignment: .leading) {
                                    HStack {
                                        Text(homework[hw].title).bold()
                                        Spacer()
                                        Text(homework[hw].subject).foregroundColor(.secondary).font(.footnote)
                                    }
                                    HStack {
                                        Text("\(homework[hw].due, formatter: Self.homeworkFormatter)").font(.callout)
                                        Spacer()
                                        if homework[hw].notify {
                                            Circle().fill(.green).frame(width: 10, height: 10)
                                        } else {
                                            Circle().fill(.red).frame(width: 10, height: 10)
                                        }
                                    }
                                    if homework[hw].comment != "" {
                                        Text(homework[hw].comment).lineLimit(3)
                                    }
                                    HStack {
                                        Spacer()
                                        Button {
                                            homework[hw].done.toggle()
                                            hwIndex = hw
                                            self.delete(at: hwIndex)
                                            try! viewContext.save()
                                        } label: {
                                            HStack {
                                                Image(systemName: "checkmark")
                                            }.frame(minWidth: UIScreen.main.bounds.width*0.33, minHeight: 25)
                                        }.buttonStyle(.bordered)
                                        Menu {
                                            Section {
                                                Button {
                                                    
                                                } label: {
                                                    Label("Share", systemImage: "square.and.arrow.up")
                                                }.disabled(true)
                                                Button {
                                                    
                                                } label: {
                                                    Label("View Details", systemImage: "ellipsis.circle")
                                                }.disabled(true)
                                                Button {
                                                    
                                                } label: {
                                                    Label("Edit", systemImage: "rectangle.and.pencil.and.ellipsis")
                                                }.disabled(true)
                                            }
                                            Section {
                                                Button {
                                                    homework[hw].done.toggle()
                                                    hwIndex = hw
                                                    self.delete(at: hwIndex)
                                                    try! viewContext.save()
                                                } label: {
                                                    Label("Complete", systemImage: "checkmark")
                                                }
                                                Button {
                                                    hwIndex = hw
                                                    deleteAlert.toggle()
                                                } label: {
                                                    Label("Delete", systemImage: "trash")
                                                }
                                            }
                                        } label: {
                                            Button {
                                                
                                            } label: {
                                                HStack {
                                                    Image(systemName: "ellipsis")
                                                }.frame(minWidth: UIScreen.main.bounds.width*0.33, minHeight: 25)
                                            }.buttonStyle(.bordered)
                                        }
                                        Spacer()
                                    }
                                }.padding()
                            }
                            .alert(isPresented: $deleteAlert) {
                                Alert(title: Text("Delete Homework?"), message: Text("This item will be permanently removed."), primaryButton: .cancel(), secondaryButton: .destructive(Text("Delete"), action: {
                                    self.delete(at: hwIndex)
                                }))
                            }
                        }
                    }.padding()
                }
                .navigationTitle("Homework")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            addHomework.toggle()
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                }
            }
        }.sheet(isPresented: $addHomework) {
            AddHomeworkSheet()
        }
    }
}

struct HomeworkView_Previews: PreviewProvider {
    static var previews: some View {
        HomeworkView()
    }
}
