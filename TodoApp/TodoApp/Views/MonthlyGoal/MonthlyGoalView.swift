//
//  NewWeeklyGoal.swift
//  TodoApp
//
//  Created by Pavol Ocelka on 06/02/2025.
//

import SwiftUI

struct MonthlyGoalView: View {
    
    @Bindable var monthlyGoal: MonthlyGoal
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack {
                TextField("Title", text: $monthlyGoal.title)
                    .foregroundStyle(.white)
                    .font(.largeTitle.bold())
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                Rectangle()
                    .stroke(Color.secondary, lineWidth: 2)
                    .frame(height: 2)
                    .padding(.horizontal)
                TextEditor(text: $monthlyGoal.descriptionText)
                    .foregroundStyle(.white)
                    .padding()
                    .scrollContentBackground(.hidden)
            }
        }
    }
}

#Preview {
    MonthlyGoalView(monthlyGoal: MonthlyGoal(title: "Test Title monthly", descriptionText: "Tesing description monthly"))
}

