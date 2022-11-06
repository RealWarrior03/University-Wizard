//
//  Homework.swift
//  TU Berlin (iOS)
//
//  Created by Henry Krieger on 11.11.21.
//

import SwiftUI

enum HomeworkOptions: Identifiable {
    case add
    case detail
    
    var id: Int {
        hashValue
    }
}

struct HomeworkView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Homework.due, ascending: true),
            NSSortDescriptor(keyPath: \Homework.title, ascending: true)
        ],
        animation: .default)
    private var homework: FetchedResults<Homework>
    
    @State var homeworkOptions: HomeworkOptions?
    @State var showType: String = "todo"
    @State var deleteAlert: Bool = false
    @State var hwIndex: Int = 0
    @State var toggleEditView: Bool = false
    
    static let homeworkFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        formatter.timeStyle = .short
        formatter.doesRelativeDateFormatting = true
        return formatter
    }()
    
    func delete(at index: Int) {
        UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: ["\(homework[hwIndex].id)"])
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["\(homework[hwIndex].id)"])
        self.viewContext.delete(homework[index])
        try! self.viewContext.save()
    }
    
    func removeNotification() {
        UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: ["\(homework[hwIndex].id)"])
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["\(homework[hwIndex].id)"])
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
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(UIColor(.secondary)).opacity(0.2).ignoresSafeArea()
                if homework.count <= 0 {
                    ZStack {
                        Text("No homework left🎉")
                        Spacer()
                    }
                }
                if self.toggleEditView {
                    NavigationLink(destination: EditHomeworkSheet(homeworkData: homework[hwIndex], title: homework[hwIndex].title, comment: homework[hwIndex].comment), isActive: $toggleEditView) {
                        EmptyView()
                    }
                }
                ScrollView {
                    VStack {
                        ForEach(homework.indices, id: \.self) { hw in
                            if self.showType.contains(homework[hw].state) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 15, style: .continuous).fill(Material.regular)
                                    VStack(alignment: .leading) {
                                        HStack {
                                            Text(homework[hw].title).bold().font(.title3)
                                            Spacer()
                                            Text(homework[hw].subject).foregroundColor(.secondary).font(.footnote)
                                        }
                                        if UserData().highlightDue {
                                            if Date().addingTimeInterval(86400) >= homework[hw].due {
                                                Text("\(homework[hw].due, formatter: Self.homeworkFormatter)").font(.callout).foregroundColor(.red)
                                            } else {
                                                Text("\(homework[hw].due, formatter: Self.homeworkFormatter)").font(.callout)
                                            }
                                        } else {
                                            Text("\(homework[hw].due, formatter: Self.homeworkFormatter)").font(.callout)
                                        }
                                        HStack {
                                            //Spacer()
                                            Button {
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
                                            }.buttonStyle(.bordered)
                                            Spacer()
                                            Menu {
                                                Section {
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
                                                    Button {
                                                        hwIndex = hw
                                                        homeworkOptions = .detail
                                                    } label: {
                                                        Label("View Details", systemImage: "ellipsis.circle")
                                                    }
                                                    Button {
                                                        hwIndex = hw
                                                        toggleEditView.toggle()
                                                    } label: {
                                                        Label("Edit", systemImage: "rectangle.and.pencil.and.ellipsis")
                                                    }
                                                }
                                                Section {
                                                    Button {
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
                                                        if homework[hw].state == "todo" {
                                                            Label("Complete", systemImage: "checkmark")
                                                        } else {
                                                            Label("Undo", systemImage: "xmark")
                                                        }
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
                                                    }.frame(maxWidth: .infinity, minHeight: 25)
                                                }.buttonStyle(.bordered)
                                            }
                                            //Spacer()
                                        }
                                    }.padding()
                                }
                                .alert(isPresented: $deleteAlert) {
                                    Alert(title: Text("Delete Homework?"), message: Text("This item will be permanently removed."), primaryButton: .cancel(), secondaryButton: .destructive(Text("Delete"), action: {
                                        self.delete(at: hwIndex)
                                    }))
                                }
                            }
                        }
                    }.padding()
                }.padding(.bottom, 100)
                .navigationTitle("Homework")
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Picker("", selection: $showType) {
                            Text("To-Do").tag("todo")
                            Text("Done").tag("done")
                            Text("All").tag("todo done")
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            homeworkOptions = .add
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                }
            }
        }.sheet(item: $homeworkOptions) { item in
            switch item {
            case .add:
                AddHomeworkSheet()
            case .detail:
                HomeworkDetailSheet(homeworkData: self.homework[hwIndex], hwIndex: self.hwIndex)
            }
        }
    }
}
