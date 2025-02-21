//
//  CreateMainGoalSheet.swift
//  TodoApp
//
//  Created by Pavol Ocelka on 08/02/2025.
//

import SwiftData
import SwiftUI

struct CreateWeeklyGoalSheet: View {
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var context
        
    @State private var weeklyGoalTitle = ""
    
    var body: some View {
        Form {
            TextField("Goal Title", text: $weeklyGoalTitle)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
        }
        Button("Create", action: create)
            .fontWeight(.bold)
            .foregroundStyle(.white)
            .frame(width: 250, height: 50)
            .background(weeklyGoalTitle.isEmpty ? Color.gray.opacity(0.3): Color.indigo)
            .clipShape(.capsule)
            .disabled(weeklyGoalTitle.isEmpty)
    }
    
    func create() {
        let weeklyGoal = WeeklyGoal(title: weeklyGoalTitle)
        context.insert(weeklyGoal)
        dismiss()
    }
}

#Preview {
    CreateWeeklyGoalSheet()
}

