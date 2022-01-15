//
//  Schedule.swift
//  TU Berlin (iOS)
//
//  Created by Henry Krieger on 08.12.21.
//

import SwiftUI

struct Schedule: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) private var presentationMode

    @FetchRequest(
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Appointment.start, ascending: true),
            NSSortDescriptor(keyPath: \Appointment.title, ascending: true)
        ],
        animation: .default)
    private var appointments: FetchedResults<Appointment>
    
    private let itemFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        return formatter
    }()
    
    @State var selectedDay: String = "Monday"
    @State var selectedType: String = "Education"
    @State var addClass: Bool = false
    
    var body: some View {
        List {
            Picker("", selection: $selectedDay) {
                Text("Mon").tag("Monday")
                Text("Tue").tag("Tuesday")
                Text("Wed").tag("Wednesday")
                Text("Thu").tag("Thursday")
                Text("Fri").tag("Friday")
            }.pickerStyle(.segmented)
            /*Picker("", selection: $selectedType) {
                Text("Personal").tag("Personal")
                Text("Education").tag("Education")
                Text("Work").tag("Work")
            }.pickerStyle(.segmented)*/
            ForEach(appointments, id: \.self) { item in
                if item.day == selectedDay && item.type == selectedType {
                    Section {
                        ScheduleItem(title: item.title, start: item.start, end: item.end, day: item.day, type: item.type)
                    }
                }
            }
            .onDelete { indexSet in
                for index in indexSet {
                    viewContext.delete(appointments[index])
                }
                do {
                    try viewContext.save()
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
        .navigationTitle("\(selectedDay)")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    addClass.toggle()
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $addClass) {
            AppointmentSheet(type: self.selectedType, day: self.selectedDay)
        }
    }
}

struct ScheduleItem: View {
    var title: String
    var start: Date
    var end: Date
    var day: String
    var type: String
    
    private let itemFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        return formatter
    }()
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(start, formatter: itemFormatter) - \(end, formatter: itemFormatter)").font(.caption).foregroundColor(.secondary)
            Text("\(title)").font(.title).bold().foregroundColor(.primary)
        }
    }
}

struct AppointmentSheet: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) private var presentationMode

    @FetchRequest(
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Appointment.start, ascending: true),
            NSSortDescriptor(keyPath: \Appointment.title, ascending: true)
        ],
        animation: .default)
    private var appointments: FetchedResults<Appointment>
    
    @State var title: String = ""
    @State var type: String
    @State var day: String
    @State var start: Date = Date(timeIntervalSince1970: 0)
    @State var end: Date = Date(timeIntervalSince1970: 0)
    
    var body: some View {
        NavigationView {
            List {
                TextField("Title", text: $title)
                
                Section(header: Text("Time")) {
                    DatePicker("Start", selection: $start, displayedComponents: .hourAndMinute)
                    DatePicker("End", selection: $end, displayedComponents: .hourAndMinute)
                }
                
                Section {
                    Picker("Day", selection: $day) {
                        Text("Monday").tag("Monday")
                        Text("Tuesday").tag("Tuesday")
                        Text("Wednesday").tag("Wednesday")
                        Text("Thursday").tag("Thursday")
                        Text("Friday").tag("Friday")
                    }.pickerStyle(.menu)
                    /*Picker("Type", selection: $type) {
                        Text("Personal").tag("Personal")
                        Text("Education").tag("Education")
                        Text("Work").tag("Work")
                    }.pickerStyle(.segmented)*/
                }
            }.navigationTitle("Add Class")
            .overlay {
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button {
                            let newDate = Appointment(context: viewContext)
                            newDate.title = self.title
                            newDate.start = self.start
                            newDate.end = self.end
                            newDate.day = self.day
                            newDate.type = self.type
                            
                            do {
                                try viewContext.save()
                                presentationMode.wrappedValue.dismiss()
                            } catch {
                                print(error.localizedDescription)
                            }
                        } label: {
                            Label("Save Class", systemImage: "square.and.arrow.down")
                        }.buttonStyle(.borderedProminent)
                    }.padding()
                }
            }
        }
    }
}

struct Schedule_Previews: PreviewProvider {
    static var previews: some View {
        Schedule()
    }
}
