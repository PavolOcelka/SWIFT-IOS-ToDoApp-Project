//
//  IdeasDetailView.swift
//  TodoApp
//
//  Created by Pavol Ocelka on 16/02/2025.
//
import SwiftData
import SwiftUI

struct IdeasDetailView: View {
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) var dismiss
    @Bindable var idea: Idea
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack {
                HStack {
                    TextField("Title", text: $idea.title)
                        .foregroundStyle(.white)
                        .font(.largeTitle.bold())
                        .autocorrectionDisabled()
                    Button(action: {delete(idea)}) {
                        Image(systemName: "trash")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30)
                            .foregroundStyle(.white)
                    }
                }
                .padding(.horizontal)
                Rectangle()
                    .stroke(Color.secondary, lineWidth: 2)
                    .frame(height: 2)
                    .padding(.horizontal)
                TextEditor(text: $idea.text)
                    .autocorrectionDisabled()
                    .foregroundStyle(.white)
                    .padding()
                    .scrollContentBackground(.hidden)
                Spacer()
            }
        }
    }
    func delete(_ idea: Idea) {
        context.delete(idea)
        
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
        
        dismiss()
    }
}


#Preview {
    IdeasDetailView(idea: Idea(title: "Test", text: "test", date: .now))
}


