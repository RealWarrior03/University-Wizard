//
//  AddSubjects.swift
//  TU Berlin (iOS)
//
//  Created by Henry Krieger on 08.12.21.
//

import SwiftUI

struct AddSubjects: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) private var presentationMode

    @FetchRequest(
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Subjects.title, ascending: true)
        ],
        animation: .default)
    private var subjects: FetchedResults<Subjects>
    
    @State var addSubject: String = ""
    
    var body: some View {
        List {
            ForEach(subjects, id: \.self) { item in
                Text(item.title)
            }
            .onDelete { indexSet in
                for index in indexSet {
                    viewContext.delete(subjects[index])
                }
                do {
                    try viewContext.save()
                } catch {
                    print(error.localizedDescription)
                }
            }
            HStack {
                TextField("Subject Title", text: $addSubject)
                Spacer()
                Button {
                    let newSubject = Subjects(context: viewContext)
                    newSubject.title = self.addSubject
                    addSubject = ""
                    
                    do {
                        try viewContext.save()
                    } catch {
                        print(error.localizedDescription)
                    }
                } label: {
                    Image(systemName: "plus")
                }.buttonStyle(.borderedProminent)
            }
        }.navigationTitle("Subjects")
    }
}

struct AddSubjects_Previews: PreviewProvider {
    static var previews: some View {
        AddSubjects()
    }
}
