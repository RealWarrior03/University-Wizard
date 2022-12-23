//
//  Settings.swift
//  TU Berlin (iOS)
//
//  Created by Henry Krieger on 11.11.21.
//

import SwiftUI

struct Settings: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) private var presentationMode
    @GestureState private var dragOffset = CGSize.zero
    
    @FetchRequest(
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Homework.due, ascending: true)
        ],
        animation: .default)
    private var homework: FetchedResults<Homework>
    
    @FetchRequest(
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Exam.due, ascending: true)
        ],
        animation: .default)
    private var exams: FetchedResults<Exam>
    
    @State private var hwAlert: Bool = false
    @State private var examAlert: Bool = false
    @State private var deleteAlert: Bool = false
    
    @State var userData = UserData()
    
    @State var dueTime: Date = Date()
    @State var examTime: Date = Date()
    @State var showDue: Bool = true
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(UIColor(.secondary)).opacity(0.2).ignoresSafeArea()
                ScrollView {
                    VStack {
                        VStack(alignment: .leading) {
                            Text("Resources").font(.caption).foregroundColor(.secondary).textCase(.uppercase).padding(.leading, 10)
                            ZStack {
                                RoundedRectangle(cornerRadius: 15, style: .continuous).fill(Material.thin)
                                VStack(alignment: .leading) {
                                    CustomNavLink(icon: "clock", text: "Add Subject", target: AnyView(AddSubjects()))
                                    CustomNavLink(icon: "link", text: "Set Websites", target: AnyView(SetWebsites()))
                                    CustomNavLink(icon: "calendar", text: "Set Schedule Categories", target: AnyView(SetCategories()))
                                }.padding()
                            }
                        }.padding(.bottom, 20)
                        
                        VStack(alignment: .leading) {
                            Text("University").font(.caption).foregroundColor(.secondary).textCase(.uppercase).padding(.leading, 10)
                            ZStack {
                                RoundedRectangle(cornerRadius: 15, style: .continuous).fill(Material.thin)
                                VStack(alignment: .leading) {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 15, style: .continuous)
                                            .fill(Material.thick)
                                        VStack {
                                            Toggle("Notifications", isOn: $userData.allowNotifications)
                                                .onTapGesture {
                                                    let manager = LocalNotificationManager()
                                                    manager.requestAuthorization()
                                                }
                                            #warning("V1.1: show note, that already existing notifications aren't affected by the toggle")
                                        }.padding()
                                    }
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 15, style: .continuous)
                                            .fill(Material.thick)
                                        VStack {
                                            DatePicker("Default Due", selection: $userData.defaultDueTime, displayedComponents: .hourAndMinute)
                                        }.padding()
                                    }
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 15, style: .continuous)
                                            .fill(Material.thick)
                                        VStack {
                                            DatePicker("Exam Time", selection: $userData.defaultExamTime, displayedComponents: .hourAndMinute)
                                        }.padding()
                                    }
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 15, style: .continuous)
                                            .fill(Material.thick)
                                        VStack {
                                            Toggle("Highlight Due within 24hrs", isOn: $userData.highlightDue)
                                        }.padding()
                                    }
                                }.padding()
                            }
                        }.padding(.bottom, 20)
                        
                        #warning("V1.1: Add App Icons and Accent Colors")
                        // COMING WITH UPDATE 1.1
                        /*VStack(alignment: .leading) {
                            Text("Customize").font(.caption).foregroundColor(.secondary).textCase(.uppercase).padding(.leading, 10)
                            ZStack {
                                RoundedRectangle(cornerRadius: 15, style: .continuous).fill(Material.thin)
                                VStack(alignment: .leading) {
                                    CustomNavLink(icon: "app.dashed", text: "App Icon", target: AnyView(Text("coming soon")))
                                    CustomNavLink(icon: "paintpalette.fill", text: "Accent Color", target: AnyView(Text("coming soon")))
                                }.padding()
                            }
                        }.padding(.bottom, 20)
                        */
                        
                        VStack(alignment: .leading) {
                            Text("Other").font(.caption).foregroundColor(.secondary).textCase(.uppercase).padding(.leading, 10)
                            ZStack {
                                RoundedRectangle(cornerRadius: 15, style: .continuous).fill(Material.thin)
                                VStack(alignment: .leading) {
                                    #warning("V1.1: Leave a Review button")
                                    //COMING WITH UPDATE 1.1
                                    //CustomNavLink(icon: "star.fill", text: "Leave a Review", target: AnyView(Text("coming soon")))
                                    #warning("V1.1: Feedback & Help page")
                                    //COMING WITH UPDATE 1.1
                                    //CustomNavLink(icon: "questionmark.circle.fill", text: "Feedback & Help", target: AnyView(Text("coming soon")))
                                    #warning("V1.1: Tip Jar")
                                    //COMING WITH UPDATE 1.1
                                    //CustomNavLink(icon: "banknote.fill", text: "Tip Jar", target: AnyView(Text("coming soon")))
                                    CustomNavLink(icon: "i.circle.fill", text: "About", target: AnyView(About()))
                                }.padding()
                            }
                        }.padding(.bottom, 20)
                        
                        VStack(alignment: .leading) {
                            Text("Danger Zone").font(.caption).foregroundColor(.secondary).textCase(.uppercase).padding(.leading, 10)
                            ZStack {
                                RoundedRectangle(cornerRadius: 15, style: .continuous).fill(Material.thin)
                                VStack(alignment: .center) {
                                    Button {
                                        hwAlert = true
                                    } label: {
                                        Label("Delete all homework", systemImage: "trash.fill")
                                    }.buttonStyle(.bordered)
                                        .alert(isPresented: $hwAlert) {
                                            Alert(title: Text("Delete all Homework"), message: Text("This will permanently delete all homework and cannot be undone"), primaryButton: .cancel(), secondaryButton: .destructive(Text("Confirm"), action: {
                                                for hw in homework {
                                                    viewContext.delete(hw)
                                                }
                                                do {
                                                    try viewContext.save()
                                                } catch {
                                                    print(error.localizedDescription)
                                                }
                                            }))
                                        }
                                    
                                    Button {
                                        examAlert = true
                                    } label: {
                                        Label("Delete all exams", systemImage: "trash.fill")
                                    }.buttonStyle(.bordered)
                                        .alert(isPresented: $examAlert) {
                                            Alert(title: Text("Delete all Exams"), message: Text("This will permanently delete all exams and cannot be undone"), primaryButton: .cancel(), secondaryButton: .destructive(Text("Confirm"), action: {
                                                for exam in exams {
                                                    viewContext.delete(exam)
                                                }
                                                do {
                                                    try viewContext.save()
                                                } catch {
                                                    print(error.localizedDescription)
                                                }
                                            }))
                                        }
                                    
                                    /*Button {
                                        
                                    } label: {
                                        Label("Delete all key cards", systemImage: "trash.fill")
                                    }.buttonStyle(.bordered).disabled(true)*/
                                    
                                    Button {
                                        deleteAlert = true
                                    } label: {
                                        Label("Reset everything", systemImage: "exclamationmark.octagon.fill")
                                    }.buttonStyle(.bordered)
                                        .alert(isPresented: $deleteAlert) {
                                            Alert(title: Text("Delete everything"), message: Text("This will permanently delete all homework & exams and cannot be undone"), primaryButton: .cancel(), secondaryButton: .destructive(Text("Confirm"), action: {
                                                for hw in homework {
                                                    viewContext.delete(hw)
                                                }
                                                for exam in exams {
                                                    viewContext.delete(exam)
                                                }
                                                do {
                                                    try viewContext.save()
                                                } catch {
                                                    print(error.localizedDescription)
                                                }
                                            }))
                                        }
                                }.padding()
                            }
                        }.padding(.bottom, 30)
                    }.padding()
                }
                .navigationTitle("Settings")
                .padding(.bottom, 75)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        HStack {
                            Image(systemName: "chevron.left")
                                .font(Font.body.weight(.bold))
                            Text("Home")
                        }
                    }
                }
            }
            .gesture(DragGesture().updating($dragOffset, body: { (value, state, transaction) in
                if(value.startLocation.x < 20 && value.translation.width > 100) {
                    self.presentationMode.wrappedValue.dismiss()
                }
            }))
        }.navigationBarHidden(true)
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
