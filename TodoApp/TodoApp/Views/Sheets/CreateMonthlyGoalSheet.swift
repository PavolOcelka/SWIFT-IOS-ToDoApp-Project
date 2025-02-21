//
//  CreateMainGoalSheet.swift
//  TodoApp
//
//  Created by Pavol Ocelka on 08/02/2025.
//

import SwiftData
import SwiftUI

struct CreateMonthlyGoalSheet: View {
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var context
        
    @State private var monthlyGoalTitle = ""
    
    var body: some View {
        Form {
            TextField("Goal Title", text: $monthlyGoalTitle)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
        }
        Button("Create", action: create)
            .fontWeight(.bold)
            .foregroundStyle(.white)
            .frame(width: 250, height: 50)
            .background(monthlyGoalTitle.isEmpty ? Color.gray.opacity(0.3): Color.blue)
            .clipShape(.capsule)
            .disabled(monthlyGoalTitle.isEmpty)
    }
    
    func create() {
        let monthlyGoal = MonthlyGoal(title: monthlyGoalTitle)
        context.insert(monthlyGoal)
        dismiss()
    }
}

#Preview {
    CreateMonthlyGoalSheet()
}


