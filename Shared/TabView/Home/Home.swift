//
//  Home.swift
//  TU Berlin (iOS)
//
//  Created by Henry Krieger on 11.11.21.
//

import SwiftUI

struct Home: View {
    @State var showSafari: Bool = false
    @FetchRequest(
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Homework.due, ascending: true),
            NSSortDescriptor(keyPath: \Homework.title, ascending: true)
        ],
        predicate: NSPredicate(format: "state == %@", "todo"),
        animation: .default)
    private var homework: FetchedResults<Homework>
    
    @FetchRequest(
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Exam.due, ascending: true),
            NSSortDescriptor(keyPath: \Exam.title, ascending: true)
        ],
        predicate: NSPredicate(format: "state = %@", "upcoming"),
        animation: .default)
    private var exams: FetchedResults<Exam>
    
    @State var userData = UserData()
    
    @State var websiteOne: Bool = false
    @State var websiteTwo: Bool = false
    @State var websiteThree: Bool = false
    
    static let homeworkFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        formatter.timeStyle = .short
        formatter.doesRelativeDateFormatting = true
        return formatter
    }()
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(UIColor(.secondary)).opacity(0.2).ignoresSafeArea()
                ScrollView {
                    VStack {
                        if userData.websiteOneURL != "" || userData.websiteTwoURL != ""  || userData.websiteThreeURL != "" {
                            ZStack {
                                RoundedRectangle(cornerRadius: 15, style: .continuous)
                                    .fill(Material.thick)
                                VStack(alignment: .leading) {
                                    HStack {
                                        Image(systemName: "link")
                                        Text("Links")
                                            .bold()
                                        Spacer()
                                    }
                                    if userData.websiteOneURL != "" && userData.websiteOneTitle != "" {
                                        Button(action: {
                                            websiteOne.toggle()
                                        }) {
                                            Label("\(userData.websiteOneTitle)", systemImage: "link").fullScreenCover(isPresented: $websiteOne) {
                                                if userData.websiteOneURL.contains("https://") {
                                                    SafariView(url: URL(string: userData.websiteOneURL)!).ignoresSafeArea(edges: .all)
                                                } else {
                                                    SafariView(url: URL(string: "https://\(userData.websiteOneURL)")!).ignoresSafeArea(edges: .all)
                                                }
                                            }
                                        }.buttonStyle(.borderedProminent)
                                    }
                                    if userData.websiteTwoURL != "" && userData.websiteTwoTitle != "" {
                                        Button(action: {
                                            websiteTwo.toggle()
                                        }) {
                                            Label("\(userData.websiteTwoTitle)", systemImage: "link").fullScreenCover(isPresented: $websiteTwo) {
                                                if userData.websiteTwoURL.contains("https://") {
                                                    SafariView(url: URL(string: userData.websiteTwoURL)!).ignoresSafeArea(edges: .all)
                                                } else {
                                                    SafariView(url: URL(string: "https://\(userData.websiteTwoURL)")!).ignoresSafeArea(edges: .all)
                                                }
                                            }
                                        }.buttonStyle(.borderedProminent)
                                    }
                                    if userData.websiteTwoURL != "" && userData.websiteThreeTitle != "" {
                                        Button(action: {
                                            websiteThree.toggle()
                                        }) {
                                            Label("\(userData.websiteThreeTitle)", systemImage: "link").fullScreenCover(isPresented: $websiteThree) {
                                                if userData.websiteThreeURL.contains("https://") {
                                                    SafariView(url: URL(string: userData.websiteThreeURL)!).ignoresSafeArea(edges: .all)
                                                } else {
                                                    SafariView(url: URL(string: "https://\(userData.websiteThreeURL)")!).ignoresSafeArea(edges: .all)
                                                }
                                            }
                                        }.buttonStyle(.borderedProminent)
                                    }
                                }.padding()
                            }
                        } else {
                            GroupBox {
                                VStack {
                                    Text("Links can be set in settings").foregroundColor(.secondary)
                                }.padding(1)
                            } label: {
                                Label("Links", systemImage: "link")
                            }
                        }
                        
                        Divider().padding(.vertical)
                        
                        CustomNavLink(icon: "calendar", text: "Schedule", target: AnyView(Schedule()))
                        //CustomNavLink(icon: "function", text: "Grades", target: AnyView(Grades()))
                        
                        Divider().padding(.vertical)
                        
                        CustomNavLink(icon: "gear", text: "Settings", target: AnyView(Settings()))
                        
                        if (homework.count > 0) {
                            Divider().padding(.vertical)
                            GroupBox {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 15, style: .continuous).fill(Material.regular)
                                    VStack(alignment: .leading) {
                                        HStack {
                                            Text(homework[0].title).bold().font(.title3)
                                            Spacer()
                                            Text(homework[0].subject).foregroundColor(.secondary).font(.footnote)
                                        }
                                        if UserData().highlightDue {
                                            if Date().addingTimeInterval(86400) >= homework[0].due {
                                                Text("\(homework[0].due, formatter: Self.homeworkFormatter)").font(.callout).foregroundColor(.red)
                                            } else {
                                                Text("\(homework[0].due, formatter: Self.homeworkFormatter)").font(.callout)
                                            }
                                        } else {
                                            Text("\(homework[0].due, formatter: Self.homeworkFormatter)").font(.callout)
                                        }
                                    }.padding()
                                }
                            } label: {
                                Label("Next Homework", systemImage: "checkmark.square")
                            }
                        } else {
                            Divider().padding(.vertical)
                            GroupBox {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 15, style: .continuous).fill(Material.regular)
                                    VStack(alignment: .leading) {
                                        Text("No homework left").bold().font(.title3)
                                    }.padding()
                                }
                            } label: {
                                Label("Next Homework", systemImage: "checkmark.square")
                            }
                        }
                        
                        if (exams.count > 0) {
                            Divider().padding(.vertical)
                            
                            GroupBox {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 15, style: .continuous).fill(Material.regular)
                                    VStack(alignment: .leading) {
                                        HStack {
                                            Text(exams[0].title).bold().font(.title3)
                                            Spacer()
                                            Text(exams[0].subject).foregroundColor(.secondary).font(.footnote)
                                        }
                                        if UserData().highlightDue {
                                            if Date().addingTimeInterval(86400) >= exams[0].due {
                                                Text("\(exams[0].due, formatter: Self.homeworkFormatter)").font(.callout).foregroundColor(.red)
                                            } else {
                                                Text("\(exams[0].due, formatter: Self.homeworkFormatter)").font(.callout)
                                            }
                                        } else {
                                            Text("\(exams[0].due, formatter: Self.homeworkFormatter)").font(.callout)
                                        }
                                    }.padding()
                                }
                            } label: {
                                Label("Next Exam", systemImage: "pencil.and.ruler.fill")
                            }
                        } else {
                            Divider().padding(.vertical)
                            GroupBox {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 15, style: .continuous).fill(Material.regular)
                                    VStack(alignment: .leading) {
                                        Text("No exam upcoming").bold().font(.title3)
                                    }.padding()
                                }
                            } label: {
                                Label("Next Exam", systemImage: "pencil.and.ruler.fill")
                            }
                        }
                        
                    }.padding().padding(.bottom, 50)
                }.padding(.bottom, 50)
                .navigationTitle("Home")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink {
                            Settings()
                        } label: {
                            Image(systemName: "gear")
                        }
                    }
                }
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
