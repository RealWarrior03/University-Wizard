//
//  AddExamSheet.swift
//  TU Berlin (iOS)
//
//  Created by Henry Krieger on 15.01.22.
//

import SwiftUI

struct AddExamSheet: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) private var presentationMode

    @FetchRequest(
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Exam.due, ascending: true),
            NSSortDescriptor(keyPath: \Exam.title, ascending: true)
        ],
        animation: .default)
    private var exams: FetchedResults<Exam>
    @FetchRequest(
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Subjects.title, ascending: true)
        ],
        animation: .default)
    private var subjects: FetchedResults<Subjects>
    
    @State var title: String = ""
    @State var comment: String = ""
    @State var subject: String = ""
    @State var due: Date = Date()
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("General Information")) {
                    TextField("Title", text: $title)
                    Picker("Subject", selection: $subject) {
                        ForEach(subjects, id: \.self) { item in
                            Text(item.title).tag(item.title)
                        }
                    }
                    DatePicker("Due Date", selection: $due, displayedComponents: [.date, .hourAndMinute])
                }
                Section(header: Text("Comment")) {
                    TextEditor(text: $comment)
                }
                
                
            }.navigationTitle("Add Exam")
            .overlay {
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button {
                            let newExam = Exam(context: viewContext)
                            newExam.title = self.title
                            newExam.subject = self.subject
                            newExam.due = self.due
                            newExam.comment = self.comment
                            newExam.done = false
                            
                            do {
                                try viewContext.save()
                                presentationMode.wrappedValue.dismiss()
                            } catch {
                                print(error.localizedDescription)
                            }
                        } label: {
                            Text("Save Exam")
                        }.buttonStyle(.borderedProminent)
                    }
                }.padding()
            }
        }
    }
}

struct AddExamSheet_Previews: PreviewProvider {
    static var previews: some View {
        AddExamSheet()
    }
}
