//
//  AddNewTaskView.swift
//  TodoApp
//
//  Created by Pavol Ocelka on 06/02/2025.
//

import SwiftUI

struct CreateNewTaskSheet: View {
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) var dismiss
    
    @State var name = ""
    @State var category = "Personal"
    
    var categories = ["Work", "Personal", "Study"]

    
    var body: some View {
        Form {
            TextField("Name", text: $name)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
            Picker("Category", selection: $category) {
                ForEach(categories, id: \.self) { category in
                    Text(category)
                }
            }
            
        }
        Button("Add", action: addNewTask)
            .fontWeight(.bold)
            .foregroundStyle(.white)
            .frame(width: 250, height: 50)
            .background(name.isEmpty ? Color.gray.opacity(0.3) : Color.green)
            .clipShape(.capsule)
            .disabled(name.isEmpty)
    }
    
    //MARK: - Functions
    
    func addNewTask() {
        let newTask = Task(name: name, category: category)
        context.insert(newTask)
        dismiss()
    }
}

#Preview {
    CreateNewTaskSheet()
}
