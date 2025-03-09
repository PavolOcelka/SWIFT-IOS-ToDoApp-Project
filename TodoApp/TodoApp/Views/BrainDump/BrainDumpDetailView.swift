//
//  BrainDumpDetailView.swift
//  TodoApp
//
//  Created by Pavol Ocelka on 16/02/2025.
//
import SwiftData
import SwiftUI

struct BrainDumpDetailView: View {
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) var dismiss
    @Bindable var brainDump: BrainDumpModel
    
    @State private var moveToIdeasSheet: Bool = false
    @State private var nonExisting: Bool = false
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack {
                HStack {
                    TextField("Title", text: $brainDump.title)
                        .foregroundStyle(.white)
                        .font(.largeTitle.bold())
                        .autocorrectionDisabled()
                    Button(action: {moveToIdeasSheet.toggle()}) {
                        Image(systemName: "arrow.forward.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30)
                            .foregroundStyle(.white)
                    }
                    Button(action: {delete(brainDump)}) {
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
                TextEditor(text: $brainDump.text)
                    .autocorrectionDisabled()
                    .foregroundStyle(.white)
                    .padding()
                    .scrollContentBackground(.hidden)
                Spacer()
            }
        }
        .sheet(isPresented: $moveToIdeasSheet) {
            MoveToIdeasSheet(brainDump: brainDump, nonExistning: $nonExisting)
                .presentationDetents([.height(400)])
        }
        .onChange(of: nonExisting) {
            if nonExisting {
                dismiss()
            }
        }
        
    }
    
    func delete(_ dump: BrainDumpModel) {
        context.delete(dump)
        
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
        
        dismiss()
    }
}

#Preview {
    BrainDumpDetailView(brainDump: BrainDumpModel(title: "Testing Preview", text: "Testing content preview", date: .now))
}

