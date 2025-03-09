//
//  IdeasView.swift
//  TodoApp
//
//  Created by Pavol Ocelka on 16/02/2025.
//

import SwiftData
import SwiftUI

struct IdeasView: View {
    
    @Environment(\.modelContext) var context
    @Query(sort: \Idea.date, order: .reverse) var ideas: [Idea]
    
    @State private var showingAddBrainDumpSheet = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.ignoresSafeArea()
                VStack {
                    HStack {
                        Text("Ideas")
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
                    
                    Text("Total: \(ideas.count)")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                        .foregroundStyle(.white.opacity(0.5))
                    
                    ScrollView {
                        ForEach(ideas, id: \.id) { idea in
                            NavigationLink (destination: IdeasDetailView(idea: idea)){
                                VStack {
                                    
                                    HStack {
                                        Text(idea.title.isEmpty ? "Brain Dump Entry" : idea.title)
                                            .foregroundStyle(.black)
                                            .font(.title.bold())
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .lineLimit(1)
                                        Text(idea.date.formatted(date: .abbreviated, time: .omitted))
                                            .font(.headline)
                                            .foregroundStyle(.black.opacity(0.5))
                                    }
                                    .padding([.horizontal, .top])
                                    Text(idea.text.isEmpty ? "Content is empty.." : idea.text)
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
    IdeasView()
}
