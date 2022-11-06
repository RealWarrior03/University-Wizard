//
//  Exams.swift
//  TU Berlin (iOS)
//
//  Created by Henry Krieger on 11.11.21.
//

import SwiftUI

enum ExamOptions: Identifiable {
    case add
    case detail
    
    var id: Int {
        hashValue
    }
}

struct ExamView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Exam.due, ascending: true),
            NSSortDescriptor(keyPath: \Exam.title, ascending: true)
        ],
        animation: .default)
    private var exams: FetchedResults<Exam>
    
    @State var examOptions: ExamOptions?
<<<<<<< Updated upstream
    
    @State var deleteAlert: Bool = false
    @State var examIndex: Int = 0
=======
    @State var showType: String = "upcoming"
    @State var deleteAlert: Bool = false
    @State var examIndex: Int = 0
    @State var toggleEditView: Bool = false
>>>>>>> Stashed changes
    
    static let examDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        formatter.timeStyle = .short
        formatter.doesRelativeDateFormatting = true
        return formatter
    }()
    
    func delete(at index: Int) {
<<<<<<< Updated upstream
=======
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["\(exams[examIndex].id)"])
        UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: ["\(exams[examIndex].id)"])
>>>>>>> Stashed changes
        self.viewContext.delete(exams[index])
        try! self.viewContext.save()
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(UIColor(.secondary)).opacity(0.2).ignoresSafeArea()
                if exams.count == 0 {
                    Text("No exams left🎉")
                }
<<<<<<< Updated upstream
                ScrollView {
                    VStack {
                        ForEach(exams.indices, id: \.self) { exam in
                            
                            
                            ZStack {
                                RoundedRectangle(cornerRadius: 15, style: .continuous).fill(Material.regular)
                                VStack(alignment: .leading) {
                                    HStack {
                                        Text(exams[exam].title).bold().font(.title3)
                                        Spacer()
                                        Text(exams[exam].subject).foregroundColor(.secondary).font(.footnote)
                                    }
                                    Text("\(exams[exam].due, formatter: Self.examDateFormatter)").font(.callout)
                                    /*if homework[hw].comment != "" {
                                        Text(homework[hw].comment).lineLimit(3).font(.footnote).foregroundColor(.secondary)
                                    }*/
                                    HStack {
                                        //Spacer()
                                        Button {
                                            exams[exam].done.toggle()
                                            examIndex = exam
                                            self.delete(at: examIndex)
                                            try! viewContext.save()
                                        } label: {
                                            HStack {
                                                Image(systemName: "checkmark")
                                            }.frame(maxWidth: .infinity, minHeight: 25)
                                        }.buttonStyle(.bordered)
                                        Spacer()
                                        Menu {
                                            Section {
                                                Button {
                                                    
                                                } label: {
                                                    Label("Share", systemImage: "square.and.arrow.up")
                                                }.disabled(true)
                                                Button {
                                                    examIndex = exam
                                                    examOptions = .detail
                                                } label: {
                                                    Label("View Details", systemImage: "ellipsis.circle")
                                                }
                                                Button {
                                                    
                                                } label: {
                                                    Label("Edit", systemImage: "rectangle.and.pencil.and.ellipsis")
                                                }.disabled(true)
                                            }
                                            Section {
                                                Button {
                                                    exams[exam].done.toggle()
                                                    examIndex = exam
                                                    self.delete(at: examIndex)
                                                    try! viewContext.save()
                                                } label: {
                                                    Label("Complete", systemImage: "checkmark")
                                                }
                                                Button {
                                                    examIndex = exam
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
                                                }.frame(maxWidth: .infinity, minHeight: 25)
                                            }.buttonStyle(.bordered)
                                        }
                                        //Spacer()
                                    }
                                }.padding()
                            }
                            .alert(isPresented: $deleteAlert) {
                                Alert(title: Text("Delete Exam?"), message: Text("This item will be permanently removed."), primaryButton: .cancel(), secondaryButton: .destructive(Text("Delete"), action: {
                                    self.delete(at: examIndex)
                                }))
                            }
                            
                            
                        }
                    }.padding()
                }
                .navigationTitle("Exams")
                .toolbar {
=======
                if self.toggleEditView {
                    NavigationLink(destination: EditExamSheet(examData: exams[examIndex], title: exams[examIndex].title, comment: exams[examIndex].comment), isActive: $toggleEditView) {
                        EmptyView()
                    }
                }
                ScrollView {
                    VStack {
                        ForEach(exams.indices, id: \.self) { exam in
                            if self.showType.contains(exams[exam].state) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 15, style: .continuous).fill(Material.regular)
                                    VStack(alignment: .leading) {
                                        HStack {
                                            Text(exams[exam].title).bold().font(.title3)
                                            Spacer()
                                            Text(exams[exam].subject).foregroundColor(.secondary).font(.footnote)
                                        }
                                        Text("\(exams[exam].due, formatter: Self.examDateFormatter)").font(.callout)
                                        /*if homework[hw].comment != "" {
                                            Text(homework[hw].comment).lineLimit(3).font(.footnote).foregroundColor(.secondary)
                                        }*/
                                        HStack {
                                            //Spacer()
                                            Button {
                                                if exams[exam].state == "upcoming" {
                                                    exams[exam].state = "done"
                                                } else {
                                                    exams[exam].state = "upcoming"
                                                }
                                                try! viewContext.save()
                                                //exams[exam].done.toggle()
                                                //examIndex = exam
                                                //self.delete(at: examIndex)
                                                //try! viewContext.save()
                                            } label: {
                                                HStack {
                                                    if exams[exam].state == "upcoming" {
                                                        Image(systemName: "checkmark")
                                                    } else {
                                                        Image(systemName: "xmark")
                                                    }
                                                }.frame(maxWidth: .infinity, minHeight: 25)
                                            }.buttonStyle(.bordered)
                                            
                                            /*Button {
                                                if homework[hw].state == "todo" {
                                                    homework[hw].state = "done"
                                                    removeNotification()
                                                } else {
                                                    homework[hw].state = "todo"
                                                    if homework[hw].notify {
                                                        scheduleNotification(hw: homework[hw])
                                                    }
                                                }
                                                try! viewContext.save()
                                            } label: {
                                                HStack {
                                                    if homework[hw].state == "todo" {
                                                        Image(systemName: "checkmark")
                                                    } else {
                                                        Image(systemName: "xmark")
                                                    }
                                                }.frame(maxWidth: .infinity, minHeight: 25)
                                            }.buttonStyle(.bordered)*/
                                            
                                            Spacer()
                                            Menu {
                                                Section {
                                                    Button {
                                                        
                                                    } label: {
                                                        Label("Share", systemImage: "square.and.arrow.up")
                                                    }.disabled(true)
                                                    Button {
                                                        examIndex = exam
                                                        examOptions = .detail
                                                    } label: {
                                                        Label("View Details", systemImage: "ellipsis.circle")
                                                    }
                                                    Button {
                                                        examIndex = exam
                                                        toggleEditView.toggle()
                                                    } label: {
                                                        Label("Edit", systemImage: "rectangle.and.pencil.and.ellipsis")
                                                    }
                                                }
                                                Section {
                                                    Button {
                                                        exams[exam].done.toggle()
                                                        examIndex = exam
                                                        self.delete(at: examIndex)
                                                        try! viewContext.save()
                                                    } label: {
                                                        Label("Complete", systemImage: "checkmark")
                                                    }
                                                    Button {
                                                        examIndex = exam
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
                                                    }.frame(maxWidth: .infinity, minHeight: 25)
                                                }.buttonStyle(.bordered)
                                            }
                                            //Spacer()
                                        }
                                    }.padding()
                                }
                                .alert(isPresented: $deleteAlert) {
                                    Alert(title: Text("Delete Exam?"), message: Text("This item will be permanently removed."), primaryButton: .cancel(), secondaryButton: .destructive(Text("Delete"), action: {
                                        self.delete(at: examIndex)
                                    }))
                                }
                            }
                        }
                    }.padding()
                }.padding(.bottom, 100)
                .navigationTitle("Exams")
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Picker("", selection: $showType) {
                            Text("Upcoming").tag("upcoming")
                            Text("Done").tag("done")
                            Text("All").tag("upcoming done")
                        }
                    }
>>>>>>> Stashed changes
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            examOptions = .add
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                }
            }.sheet(item: $examOptions) { item in
                switch item {
                case .add:
                    AddExamSheet()
                case .detail:
                    ExamDetailSheet(examData: self.exams[examIndex])
                }
            }
        }
    }
}

struct ExamView_Previews: PreviewProvider {
    static var previews: some View {
        ExamView()
    }
}
