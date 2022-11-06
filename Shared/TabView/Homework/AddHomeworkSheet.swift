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
    
<<<<<<< Updated upstream
    @State var title: String = ""
    @State var comment: String = ""
    @State var subject: String = ""
    @State var due: Date = Date()
    @State var notification: Bool = false
=======
    private let itemFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()
    
    @State var title: String = ""
    @State var comment: String = ""
    @State var subject: String = ""
    @State var id: UUID = UUID()
    @State var due: Date = UserData().defaultDueTime
    @State var notify: Bool = false
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
                Section(header: Text("Comment")) {
                    TextEditor(text: $comment)
                }
                Section(header: Text("Notification")) {
                    Toggle("Notification?", isOn: $notification)
                    if notification {
                        DatePicker("Notification", selection: $notifyTime, displayedComponents: [.date, .hourAndMinute])
                    }
                }
                
                
=======
                
                Section(header: Text("Comment")) {
                    TextEditor(text: $comment)
                }
                
                if UserData().allowNotifications {
                    Section(header: Text("Notification")) {
                        Toggle("Set up a notification?", isOn: $notify)
                            .onChange(of: notify) { newValue in
                                notifyTime = due.addingTimeInterval(-86400)
                            }
                        if notify {
                            DatePicker("", selection: $notifyTime, displayedComponents: [.date, .hourAndMinute])
                        }
                    }
                }
                
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
                            newHW.notify = self.notification
                            newHW.notification = self.notifyTime
                            newHW.done = false
=======
                            newHW.notify = self.notify
                            newHW.notification = self.notifyTime
                            newHW.done = false
                            newHW.state = "todo"
                            newHW.id = self.id
                            
                            if self.notify {
                                let manager = LocalNotificationManager()
                                let messageDate = self.notifyTime
                                let dateComponents = Calendar.current.dateComponents([.hour, .minute], from: messageDate)
                                let formattedDate = due.formatted(date: .complete, time: .omitted)
                                let formattedTime = due.formatted(date: .omitted, time: .shortened)
                                manager.notifications = [
                                    Notification(id: "\(self.id)", title: "Homework Reminder", datetime: dateComponents, body: "\(self.title) in \(self.subject) is due to \(formattedDate) at \(formattedTime)")
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
