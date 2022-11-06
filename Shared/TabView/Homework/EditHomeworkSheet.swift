//
//  EditHomeworkSheet.swift
//  TU Berlin (iOS)
//
//  Created by Henry Krieger on 11.03.22.
//

import SwiftUI

struct EditHomeworkSheet: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) private var presentationMode
    
    var homeworkData: FetchedResults<Homework>.Element
    
    @FetchRequest(
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Subjects.title, ascending: true)
        ],
        animation: .default)
    private var subjects: FetchedResults<Subjects>
    
    private let homeworkFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .short
        return formatter
    }()
    
    @State var title: String
    @State var comment: String
    @State var subject: String = ""
    @State var id: UUID = UUID()
    @State var due: Date = Date()
    @State var notify: Bool = false
    @State var notifyTime: Date = Date().addingTimeInterval(86400)
    
    var body: some View {
        ZStack {
            Color(UIColor.secondarySystemBackground).ignoresSafeArea()
            List {
                Section(header: Text("Title")) {
                    TextField("Title", text: $title)
                }
                
                Section(header: Text("Due")) {
                    DatePicker("Due Date", selection: $due)
                }
                
                Section(header: Text("Class")) {
                    Picker("Subject", selection: $subject) {
                        ForEach(subjects, id: \.self) { item in
                            Text(item.title).tag(item.title)
                        }
                    }.pickerStyle(.menu)
                }
                
                Section(header: Text("Comment")) {
                    TextField("Comment", text: $comment)
                }
                
                if UserData().allowNotifications {
                    Section(header: Text("Notification")) {
                        Toggle("Set up a notification?", isOn: $notify)
                        if notify {
                            DatePicker("", selection: $notifyTime, displayedComponents: [.date, .hourAndMinute])
                        }
                    }
                }
            }
            .padding(.bottom, 100)
        }
        .navigationTitle("Edit Homework")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    homeworkData.title = self.title
                    homeworkData.subject = self.subject
                    homeworkData.due = self.due
                    homeworkData.comment = self.comment
                    homeworkData.notify = self.notify
                    homeworkData.notification = self.notifyTime
                    homeworkData.done = false
                    homeworkData.state = "todo"
                    homeworkData.id = self.id
                    
                    UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: ["\(id)"])
                    UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["\(id)"])
                    
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
                    
                    do {
                        try viewContext.save()
                        presentationMode.wrappedValue.dismiss()
                    } catch {
                        print(error.localizedDescription)
                    }
                } label: {
                    Text("Save")
                }.buttonStyle(.bordered)
            }
        }
        .onAppear {
            self.title = homeworkData.title
            self.due = homeworkData.due
            self.subject = homeworkData.subject
            self.notify = homeworkData.notify
            self.notifyTime = homeworkData.notification
            self.comment = homeworkData.comment
            self.id = homeworkData.id
        }
    }
}
