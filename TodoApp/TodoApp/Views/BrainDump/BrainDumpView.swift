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
    @Query(sort: \BrainDumpModel.date, order: .reverse) var brainDumps: [BrainDumpModel]
    
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
                                .frame(width: 30)
                        }
                        .foregroundStyle(.white)
                        .padding(.horizontal)
                    }
                    Text("Total: \(brainDumps.count)")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                        .foregroundStyle(.white.opacity(0.5))
                    
                    ScrollView {
                        ForEach(brainDumps, id: \.id) { brainDump in
                            NavigationLink (destination: BrainDumpDetailView(brainDump: brainDump)){
                                VStack {
                                    
                                    HStack {
                                        Text(brainDump.title.isEmpty ? "Brain Dump Entry" : brainDump.title)
                                            .foregroundStyle(.black)
                                            .font(.title.bold())
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .lineLimit(1)
                                        Text(brainDump.date.formatted(date: .abbreviated, time: .omitted))
                                            .font(.headline)
                                            .foregroundStyle(.black.opacity(0.5))
                                    }
                                    .padding([.horizontal, .top])
                                    Text(brainDump.text.isEmpty ? "Content is empty.." : brainDump.text)
                                        .foregroundStyle(.black)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding([.horizontal, .bottom])
                                        .multilineTextAlignment(.leading)
                                }
                                .background(Color.white)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .frame(maxWidth: .infinity, minHeight: 100, maxHeight: 220)
                            }
                        }
                    }
                    .padding(.horizontal)
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
