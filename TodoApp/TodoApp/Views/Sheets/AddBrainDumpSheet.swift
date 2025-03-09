//
//  AddBrainDumpSheet.swift
//  TodoApp
//
//  Created by Pavol Ocelka on 21/02/2025.
//

import SwiftUI

struct AddBrainDumpSheet: View {
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var content = ""
        
    var body: some View {
        Form {
            TextField("Title", text: $title)
                .autocorrectionDisabled()
            ZStack {
                if content.isEmpty {
                    Text("Enter Content")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundStyle(.secondary.opacity(0.5))
                }
                TextEditor(text: $content)
                    .autocorrectionDisabled()
                    .frame(maxHeight: 250)
            }
        }
        Button("Add", action: addNewBRainDump)
            .fontWeight(.bold)
            .foregroundStyle(.white)
            .frame(width: 250, height: 50)
            .background(title.isEmpty || content.isEmpty ? Color.gray.opacity(0.3) : Color.green)
            .clipShape(.capsule)
            .disabled(title.isEmpty || content.isEmpty)
    }
    
    func addNewBRainDump() {
        let newDump = BrainDumpModel(title: title, text: content, date: .now)
        context.insert(newDump)
        dismiss()
    }
}

#Preview {
    AddBrainDumpSheet()
}
