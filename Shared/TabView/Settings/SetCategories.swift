//
//  SetCategories.swift
//  TU Berlin (iOS)
//
//  Created by Henry Krieger on 26.09.22.
//

import SwiftUI

struct SetCategories: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) private var presentationMode
    
    @FetchRequest(
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Categories.name, ascending: true)
        ],
        animation: .default)
    private var categories: FetchedResults<Categories>
    
    @State var addCategory: String = ""
    
    private enum Field: Int, Hashable {
        case subject
    }
    @FocusState private var focusedField: Field?
    
    func saveCategory() {
        let newCategory = Categories(context: viewContext)
        newCategory.name = self.addCategory
        addCategory = ""
        
        do {
            try viewContext.save()
        } catch {
            print(error.localizedDescription)
        }
        
        self.addCategory = ""
        focusedField = .subject
    }
    
    var body: some View {
        List {
            ForEach(categories, id: \.self) { item in
                Text(item.name)
            }
            .onDelete { indexSet in
                for index in indexSet {
                    viewContext.delete(categories[index])
                }
                do {
                    try viewContext.save()
                } catch {
                    print(error.localizedDescription)
                }
            }
            HStack {
                TextField("Category Name", text: $addCategory).focused($focusedField, equals: .subject)
                    .onSubmit {
                        saveCategory()
                    }
                Spacer()
                Button {
                    saveCategory()
                } label: {
                    Image(systemName: "plus")
                }.buttonStyle(.borderedProminent)
            }
        }.navigationTitle("Schedule Categories")
    }
}

struct SetCategories_Previews: PreviewProvider {
    static var previews: some View {
        SetCategories()
    }
}
