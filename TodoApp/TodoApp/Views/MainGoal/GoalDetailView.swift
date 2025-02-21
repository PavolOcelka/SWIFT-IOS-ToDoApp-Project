//
//  GoalDetailView.swift
//  TodoApp
//
//  Created by Pavol Ocelka on 07/02/2025.
//

import SwiftUI

struct GoalDetailView: View {
    @Bindable var mainGoal: Goal
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack {
                TextField("Task name", text: $mainGoal.title)
                    .foregroundStyle(.white)
                    .font(.largeTitle.bold())
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                Rectangle()
                    .stroke(Color.secondary, lineWidth: 2)
                    .frame(height: 2)
                    .padding(.horizontal)
                Text("Description:")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading)
                    .foregroundStyle(.secondary)
                TextEditor(text: $mainGoal.descriptionText)
                    .foregroundStyle(.white)
                    .padding(.horizontal)
                    .scrollContentBackground(.hidden)
            }
        }
    }
}

#Preview {
    GoalDetailView(mainGoal: Goal(title: "Test", descriptionText: "Testing", parts: 0))
}
