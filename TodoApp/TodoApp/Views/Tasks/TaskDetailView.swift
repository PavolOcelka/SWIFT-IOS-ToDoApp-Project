//
//  TaskDetailView.swift
//  TodoApp
//
//  Created by Pavol Ocelka on 07/02/2025.
//

import SwiftUI

struct TaskDetailView: View {
    
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) var dismiss
    
    @Bindable var task: Task
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack {
                TextField("Task name", text: $task.name)
                    .foregroundStyle(.white)
                    .font(.largeTitle.bold())
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                Rectangle()
                    .stroke(Color.secondary, lineWidth: 2)
                    .frame(height: 2)
                    .padding(.horizontal)
                TextField("Category", text: $task.category)
                    .foregroundStyle(.white)
                    .font(.title2)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                Rectangle()
                    .stroke(Color.secondary, lineWidth: 2)
                    .frame(height: 2)
                    .padding(.horizontal)
                TextEditor(text: $task.taskDescription)
                    .foregroundStyle(.white)
                    .padding()
                    .scrollContentBackground(.hidden)
            }
        }
        
    }
}

#Preview {
    TaskDetailView(task: Task(name: "Test", category: "Personal"))
}
