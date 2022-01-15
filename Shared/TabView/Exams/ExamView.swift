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
    
    @State var deleteAlert: Bool = false
    @State var examIndex: Int = 0
    
    static let examDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        formatter.timeStyle = .short
        formatter.doesRelativeDateFormatting = true
        return formatter
    }()
    
    func delete(at index: Int) {
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
