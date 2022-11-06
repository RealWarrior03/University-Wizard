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
<<<<<<< Updated upstream
=======
    @State var notify: Bool = false
    @State var notification: Date = Date()
    @State var id: UUID = UUID()
>>>>>>> Stashed changes
    
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
                
<<<<<<< Updated upstream
=======
                if UserData().allowNotifications {
                    Toggle("Set up a notification?", isOn: $notify)
                        .onChange(of: notify) { newValue in
                            notification = due.addingTimeInterval(-86400)
                        }
                    if self.notify {
                        DatePicker("", selection: $notification, displayedComponents: [.date, .hourAndMinute])
                    }
                }
                
>>>>>>> Stashed changes
                
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
<<<<<<< Updated upstream
=======
                            newExam.notify = self.notify
                            newExam.notification = self.notification
                            newExam.id = self.id
                            newExam.state = "upcoming"
                            
                            if self.notify {
                                let manager = LocalNotificationManager()
                                let messageDate = self.notification
                                let dateComponents = Calendar.current.dateComponents([.hour, .minute], from: messageDate)
                                let formattedDate = due.formatted(date: .complete, time: .omitted)
                                let formattedTime = due.formatted(date: .omitted, time: .shortened)
                                manager.notifications = [
                                    Notification(id: "\(self.id)", title: "Exam Reminder", datetime: dateComponents, body: "\(self.title) in \(self.subject) is due to \(formattedDate) at \(formattedTime)")
                                ]
                                manager.schedule()
                            }
>>>>>>> Stashed changes
                            
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
