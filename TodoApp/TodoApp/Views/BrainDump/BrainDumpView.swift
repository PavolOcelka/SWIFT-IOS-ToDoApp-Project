//
//  BrainDumpView.swift
//  TodoApp
//
//  Created by Pavol Ocelka on 16/02/2025.
//

import SwiftData
import SwiftUI

struct BrainDumpView: View {
    
    @Environment(\.modelContext) var context
    @Query var brainDumps: [BrainDumpModel]
    
    @State private var showingAddBrainDumpSheet = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.ignoresSafeArea()
                VStack {
                    HStack {
                        Text("Brain Dumps")
                            .font(.largeTitle.bold())
                            .foregroundStyle(.white)
                            .padding(.horizontal)
                        Spacer()
                        Button(action: {showingAddBrainDumpSheet = true}) {
                            Image(systemName: "plus.circle")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 32, height: 32)
                        }
                        .foregroundStyle(.white)
                        .padding(.horizontal)
                    }
                    
                    List {
                        ForEach(brainDumps, id: \.id) { brainDump in
                            VStack {
                                Text(brainDump.title.isEmpty ? "Brain Dump Entry" : brainDump.title)
                                    .font(.title.bold())
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding([.horizontal, .top])
                                Text(brainDump.text.isEmpty ? "Content is empty.." : brainDump.text)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding([.horizontal, .bottom])
                                    .multilineTextAlignment(.leading)
                            }
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .frame(maxWidth: .infinity, minHeight: 100, maxHeight: 220)
                            .padding()
                        }
                    }
                    .scrollContentBackground(.hidden)
                }
            }
        }
        .sheet(isPresented: $showingAddBrainDumpSheet) {
            AddBrainDumpSheet()
                .presentationDetents([.height(300)])
        }
    }
}

#Preview {
    BrainDumpView()
}
