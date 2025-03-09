//
//  TaskDetailView.swift
//  TodoApp
//
//  Created by Pavol Ocelka on 07/02/2025.
//

import SwiftData
import SwiftUI

struct TaskDetailView: View {
    
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) var dismiss
    
    @Bindable var task: Task
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack {
                HStack {
                    TextField("Task name", text: $task.name)
                        .foregroundStyle(.white)
                        .font(.largeTitle.bold())
                    Button(action: {delete(task)}) {
                        Image(systemName: "trash")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 30)
                            .foregroundStyle(.white)
                    }
                }
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
    func delete(_ task: Task) {
        context.delete(task)
        
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
        dismiss()
    }
    }
#Preview {
    TaskDetailView(task: Task(name: "Test", category: "Personal"))
}
