//
//  NewWeeklyGoal.swift
//  TodoApp
//
//  Created by Pavol Ocelka on 06/02/2025.
//

import SwiftUI

struct PartDetailView: View {
    
    @Bindable var partDetails: GoalPart
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack {
                TextField("Title", text: $partDetails.title)
                    .foregroundStyle(.white)
                    .font(.largeTitle.bold())
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                Rectangle()
                    .stroke(Color.secondary, lineWidth: 2)
                    .frame(height: 2)
                    .padding(.horizontal)
                TextEditor(text: $partDetails.descriptionText)
                    .foregroundStyle(.white)
                    .padding()
                    .scrollContentBackground(.hidden)
            }
        }
    }
}

#Preview {
    PartDetailView(partDetails: GoalPart(title: "Title Goal part test", descriptionText: "Goal Part description dtesing"))
}

