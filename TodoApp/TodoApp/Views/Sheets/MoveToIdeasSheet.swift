//
//  MoveToIdeasSheet.swift
//  TodoApp
//
//  Created by Pavol Ocelka on 09/03/2025.
//

import SwiftData
import SwiftUI

struct MoveToIdeasSheet: View {
    @Bindable var brainDump: BrainDumpModel
    @Binding var nonExistning: Bool
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Title", text: $brainDump.title)
                    .autocorrectionDisabled()
                ZStack {
                    if brainDump.text.isEmpty {
                        Text("Enter Content")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundStyle(.secondary.opacity(0.5))
                    }
                    TextEditor(text: $brainDump.text)
                        .autocorrectionDisabled()
                        .frame(maxHeight: 250)
                }
            }
            Button(action: {
                moveBrainDumpToIdeas()
                dismiss()
            })
            {
                Text("Move to ideas")
            }
            .fontWeight(.bold)
            .foregroundStyle(.white)
            .frame(width: 250, height: 50)
            .background(brainDump.text.isEmpty || brainDump.text.isEmpty ? Color.gray.opacity(0.3) : Color.green)
            .clipShape(.capsule)
            .disabled(brainDump.text.isEmpty || brainDump.text.isEmpty)
            
        }
    }
    
    func moveBrainDumpToIdeas() {
        let newIdea = Idea(title: brainDump.title, text: brainDump.text, date: .now)
        context.insert(newIdea)
        
        context.delete(brainDump)
        
        do {
            try context.save()
        } catch {
            print("Failed to save context: \(error.localizedDescription)")
        }
        nonExistning.toggle()
        
    }
}

#Preview {
    MoveToIdeasSheet(brainDump: BrainDumpModel(title: "Test", text: "test", date: .now), nonExistning: .constant(false))
}
