//
//  GoalView.swift
//  TodoApp
//
//  Created by Pavol Ocelka on 07/02/2025.
//

import SwiftData
import SwiftUI

struct GoalView: View {
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) var dismiss
    
    @Query var mainGoal: [Goal]
    @Query var goalPart: [GoalPart]
    
    @State private var showingSheet = false
    
    @State private var goalTitle = ""
    @State private var goalDescription = ""
    @State private var partsSelected = 1

    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.ignoresSafeArea()
                VStack {
                    if mainGoal.isEmpty {
                        Button(action: {
                            showingSheet.toggle()
                        }) {
                            Text("Set up new goal")
                                .font(.largeTitle.bold())
                                .foregroundStyle(.white)
                        }
                        .frame(maxWidth: .infinity, maxHeight: 150)
                        .background(LinearGradient.elementGradient3)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .padding()
                        
                        Text("Set up your main goal, and start breaking it down into smaller steps.")
                            .foregroundStyle(.white.opacity(0.5))
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                        
                        Spacer()
                    } else {
                        NavigationLink(destination: GoalDetailView(mainGoal: mainGoal.first!)) {
                            VStack {
                                Text(mainGoal.first?.title ?? "Goal")
                                    .font(.largeTitle.bold())
                                    .foregroundStyle(.white)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.horizontal)
                                Text(mainGoal.first?.descriptionText.isEmpty == true ? "Add detailed description into your goal." : mainGoal.first?.descriptionText ?? "")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .foregroundStyle(.gray)
                                    .padding(.horizontal)
                                    .multilineTextAlignment(.leading)
                                    .lineLimit(4)
                            }
                        }
                        .frame(maxWidth: .infinity, maxHeight: 150)
                        .background(LinearGradient.elementGradient3)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .padding()
                        
                        Spacer()
                    }
                    
                    VStack {
                        if !mainGoal.isEmpty && !goalPart.isEmpty{
                            ProgressView(value: mainGoal.first?.progress, total: Float(goalPart.count))
                                .accentColor(.green)
                                .padding(.horizontal)
                        }
                        if !mainGoal.isEmpty && goalPart.allSatisfy(\.isCompleted) {
                            Button("Finish", action: {
                                withAnimation {
                                    delete()
                                }
                            })
                            .frame(width: 150, height: 40)
                            .background(.opacity(0.2))
                            .clipShape(Capsule())
                            .font(.title2.bold())
                            .foregroundStyle(.green)
                        }
                        ScrollView {
                            ForEach(goalPart) { part in
                                VStack(spacing: 3) {
                                    NavigationLink (destination: PartDetailView(partDetails: part)){
                                        VStack {
                                            HStack {
                                                Text(part.title)
                                                    .font(.title.bold())
                                                    .foregroundStyle(!part.isCompleted ? LinearGradient.elementGradient3 : LinearGradient.elementGradientWhite)
                                                    .frame(maxWidth: .infinity, alignment: .leading)
                                                    .padding()
                                                Button(action: {
                                                        withAnimation {
                                                            deleteGoalPart(part: part)
                                                        }
                                                }) {
                                                    Image(systemName: !part.isCompleted ? "trash.fill" : "checkmark.circle.fill")
                                                        .foregroundStyle(!part.isCompleted ? LinearGradient.elementGradient3 : LinearGradient.elementGradientGreen)
                                                        .padding(.horizontal)
                                                }
                                                .disabled(part.isCompleted)
                                            }
                                        }
                                        .frame(height: 50)
                                        .clipShape(RoundedRectangle(cornerRadius: 5))
                                    }
                                    
                                    if !part.isCompleted {
                                        Button("Complete", action: {
                                            withAnimation {
                                                completePart(part: part)
                                            }
                                        })
                                        .frame(width: 250, height: 50)
                                        .foregroundStyle(.white)
                                        .background(LinearGradient.elementGradient3)
                                        .clipShape(Capsule())
                                        .padding(.vertical)
                                    }
                                }
                                .background(part.isCompleted ? Color.white.opacity(0.2) : Color.white)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .padding(.horizontal)
                            }
                        }
                    }
                }
            }
        }
        .sheet(isPresented: $showingSheet) {
            CreateMainGoalSheet()
                .presentationDetents([.height(250)])
        }
        
    }
    
    //MARK: - Functions
    func completePart(part: GoalPart) {
        mainGoal.first?.progress += 1
        part.isCompleted.toggle()
    }
    
    func deleteGoalPart(part: GoalPart) {
        withAnimation {
            context.delete(part)
        }
        
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
    
    func delete() {
        for goal in mainGoal {
            context.delete(goal)
        }
        
        for goalPart in goalPart {
            context.delete(goalPart)
        }
        
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
    
}

#Preview {
    GoalView()
}
