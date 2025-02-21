//
//  CreateMainGoalSheet.swift
//  TodoApp
//
//  Created by Pavol Ocelka on 08/02/2025.
//

import SwiftData
import SwiftUI

struct CreateMainGoalSheet: View {
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var context
    
    @Query var mainGoal: [Goal]
    @Query var goalPart: [GoalPart]
    
    @State private var goalTitle = ""
    @State private var goalDescription = ""
    @State private var partsSelected = 1
    
    var body: some View {
            Form {
                TextField("Goal Title", text: $goalTitle)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                Stepper(value: $partsSelected, in: 1...20) {
                    Text("Goal Parts: \(partsSelected)")
                }
            }
            Button("Create", action: create)
                .fontWeight(.bold)
                .foregroundStyle(.white)
                .frame(width: 250, height: 50)
                .background(goalTitle.isEmpty ? Color.gray.opacity(0.3): Color.green)
                .clipShape(.capsule)
                .disabled(goalTitle.isEmpty)
    }
    
    func create() {
        delete()
        addGoal()
        mainGoal.first?.progress = 0
        dismiss()
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
    
    func addGoal() {
        
        for _ in 0..<partsSelected {
            let new = GoalPart(title: "Goal Part", descriptionText: "Description")
            context.insert(new)
        }
        let newGoal = Goal(title: goalTitle, descriptionText: goalDescription, parts: partsSelected)
        context.insert(newGoal)
        
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
            return
        }
                
    }
}

#Preview {
    CreateMainGoalSheet()
}
