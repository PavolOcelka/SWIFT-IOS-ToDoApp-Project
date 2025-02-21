//
//  NewWeeklyGoal.swift
//  TodoApp
//
//  Created by Pavol Ocelka on 06/02/2025.
//

import SwiftUI

struct WeeklyGoalView: View {
    
    @Bindable var weeklyGoal: WeeklyGoal
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack {
                TextField("Title", text: $weeklyGoal.title)
                    .foregroundStyle(.white)
                    .font(.largeTitle.bold())
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                Rectangle()
                    .stroke(Color.secondary, lineWidth: 2)
                    .frame(height: 2)
                    .padding(.horizontal)
                TextEditor(text: $weeklyGoal.descriptionText)
                    .foregroundStyle(.white)
                    .padding()
                    .scrollContentBackground(.hidden)
            }
        }
    }
}

#Preview {
    WeeklyGoalView(weeklyGoal: WeeklyGoal(title: "Test Title weekly", descriptionText: "Tesing description weekly"))
}
