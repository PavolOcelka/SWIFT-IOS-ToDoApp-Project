//
//  BrainDumpDetailView.swift
//  TodoApp
//
//  Created by Pavol Ocelka on 16/02/2025.
//

import SwiftUI

struct BrainDumpDetailView: View {
    @Bindable var brainDump: BrainDumpModel
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack {
                TextField("Title", text: $brainDump.title)
                    .foregroundStyle(.white)
                    .font(.largeTitle.bold())
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .autocorrectionDisabled()
                Rectangle()
                    .stroke(Color.secondary, lineWidth: 2)
                    .frame(height: 2)
                    .padding(.horizontal)
                TextEditor(text: $brainDump.text)
                    .autocorrectionDisabled()
                    .foregroundStyle(.white)
                    .padding()
                    .scrollContentBackground(.hidden)
                Rectangle()
                    .stroke(Color.secondary, lineWidth: 2)
                    .frame(height: 2)
                    .padding(.horizontal)
                    Button(action: {}) {
                        Text("Move")
                    }
                    .frame(width: 100, height: 40)
                    .background(.white)
                    .clipShape(Capsule())
                    .foregroundStyle(.black)
            }
        }
    }
}

#Preview {
    BrainDumpDetailView(brainDump: BrainDumpModel(title: "Testing Preview", text: "Testing content preview", date: .now))
}

