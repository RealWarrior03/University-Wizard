//
//  AddHomeworkSheet.swift
//  TU Berlin (iOS)
//
//  Created by Henry Krieger on 30.11.21.
//

import SwiftUI

struct AddHomeworkSheet: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) private var presentationMode

    @FetchRequest(
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Homework.due, ascending: true),
            NSSortDescriptor(keyPath: \Homework.title, ascending: true)
        ],
        animation: .default)
    private var homework: FetchedResults<Homework>
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
    @State var notification: Bool = false
    @State var notifyTime: Date = Date().addingTimeInterval(86400)
    
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
                Section(header: Text("Notification")) {
                    Toggle("Notification?", isOn: $notification)
                    if notification {
                        DatePicker("Notification", selection: $notifyTime, displayedComponents: [.date, .hourAndMinute])
                    }
                }
                
                
            }.navigationTitle("Add Homework")
            .overlay {
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button {
                            let newHW = Homework(context: viewContext)
                            newHW.title = self.title
                            newHW.subject = self.subject
                            newHW.due = self.due
                            newHW.comment = self.comment
                            newHW.notify = self.notification
                            newHW.notification = self.notifyTime
                            newHW.done = false
                            
                            do {
                                try viewContext.save()
                                presentationMode.wrappedValue.dismiss()
                            } catch {
                                print(error.localizedDescription)
                            }
                        } label: {
                            Text("Save Homework")
                        }.buttonStyle(.borderedProminent)
                    }
                }.padding()
            }
        }
    }
}

struct AddHomeworkSheet_Previews: PreviewProvider {
    static var previews: some View {
        AddHomeworkSheet()
    }
}
