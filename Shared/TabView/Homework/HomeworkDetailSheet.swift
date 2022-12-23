//
//  HomeworkDetailSheet.swift
//  TU Berlin (iOS)
//
//  Created by Henry Krieger on 09.12.21.
//

import SwiftUI

struct HomeworkDetailSheet: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) private var presentationMode
    
    var homeworkData: FetchedResults<Homework>.Element
    
    private let homeworkFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .short
        return formatter
    }()
    
    func delete() {
        UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: ["\(homeworkData.id)"])
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["\(homeworkData.id)"])
        self.viewContext.delete(homeworkData)
        do {
            try viewContext.save()
            leaveView = true
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func removeNotification() {
        UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: ["\(homeworkData.id)"])
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["\(homeworkData.id)"])
        print("removed notification")
    }
    
    func scheduleNotification(hw: Homework) {
        let manager = LocalNotificationManager()
        let messageDate = hw.notification
        let dateComponents = Calendar.current.dateComponents([.hour, .minute], from: messageDate)
        let formattedDate = hw.due.formatted(date: .complete, time: .omitted)
        let formattedTime = hw.due.formatted(date: .omitted, time: .shortened)
        manager.notifications = [
            Notification(id: "\(hw.id)", title: "Homework Reminder", datetime: dateComponents, body: "\(hw.title) in \(hw.subject) is due to \(formattedDate) at \(formattedTime)")
        ]
        manager.schedule()
        print("scheduled notification")
    }
    
    @State var deleteAlert: Bool = false
    @State var hwIndex: Int
    @State var leaveView: Bool = false
    @State var toggleEditView: Bool = false
    
    var body: some View {
        NavigationView {
            if self.toggleEditView {
                NavigationLink(destination: EditHomeworkSheet(homeworkData: homeworkData, title: homeworkData.title, comment: homeworkData.comment), isActive: $toggleEditView) {
                    EmptyView()
                }
            }
            if leaveView {
                EmptyView()
                    .onAppear {
                        presentationMode.wrappedValue.dismiss()
                    }
            } else {
                List {
                    Section(header: Text("Due")) {
                        Text("\(homeworkData.due, formatter: homeworkFormatter)")
                    }
                    
                    Section(header: Text("Class")) {
                        Text("\(homeworkData.subject)")
                    }
                    
                    Section(header: Text("Comment")) {
                        Text("\(homeworkData.comment)")
                    }
                    
                    Section(header: Text("Notification")) {
                        if homeworkData.notify {
                            Text("\(homeworkData.notification, formatter: homeworkFormatter)")
                        } else {
                            Text("No notification scheduled")
                        }
                    }
                }
                .navigationTitle(homeworkData.title)
                .overlay {
                    VStack {
                        Spacer()
                        HStack {
                            Button {
                                if homeworkData.state == "todo" {
                                    homeworkData.state = "done"
                                    removeNotification()
                                } else {
                                    homeworkData.state = "todo"
                                    if homeworkData.notify {
                                        scheduleNotification(hw: homeworkData)
                                    }
                                }
                                try! viewContext.save()
                            } label: {
                                HStack {
                                    if homeworkData.state == "todo" {
                                        Image(systemName: "checkmark")
                                    } else {
                                        Image(systemName: "xmark")
                                    }
                                }
                                .frame(maxWidth: .infinity, minHeight: 25)
                            }.buttonStyle(.borderedProminent)
                            Menu {
                                #warning("V1.1: enable all buttons in the menu")
                                Section {
                                    Button {
                                        deleteAlert.toggle()
                                    } label: {
                                        Label("Delete", systemImage: "trash")
                                    }.disabled(true)
                                    Button {
                                        if homeworkData.state == "todo" {
                                            homeworkData.state = "done"
                                            removeNotification()
                                        } else {
                                            homeworkData.state = "todo"
                                            if homeworkData.notify {
                                                scheduleNotification(hw: homeworkData)
                                            }
                                        }
                                        try! viewContext.save()
                                    } label: {
                                        if homeworkData.state == "todo" {
                                            Label("Complete", systemImage: "checkmark")
                                        } else {
                                            Label("Undo", systemImage: "xmark")
                                        }
                                    }
                                }
                                Section {
                                    Button {
                                        toggleEditView.toggle()
                                    } label: {
                                        Label("Edit", systemImage: "rectangle.and.pencil.and.ellipsis")
                                    }
                                    Menu {
                                        Button {
                                            //soon
                                        } label: {
                                            Label("Generate QR Code", systemImage: "qrcode")
                                        }.disabled(true)
                                        Button {
                                            //soon
                                        } label: {
                                            Label("Copy to clipboard", systemImage: "doc.on.clipboard")
                                        }.disabled(true)
                                    } label: {
                                        Label("Share", systemImage: "square.and.arrow.up")
                                    }
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
                .alert(isPresented: $deleteAlert) {
                    Alert(title: Text("Delete Homework?"), message: Text("This item will be permanently removed."), primaryButton: .cancel(), secondaryButton: .destructive(Text("Delete"), action: {
                        self.delete()
                    }))
                }
            }
        }
    }
}
