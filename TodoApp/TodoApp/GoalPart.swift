//
//  Part.swift
//  TodoApp
//
//  Created by Pavol Ocelka on 07/02/2025.
//

import Foundation
import SwiftData

@Model
class GoalPart {
    var title: String
    var descriptionText: String
    
    var isCompleted: Bool
    
    init(title: String, descriptionText: String, isCompleted: Bool = false) {
        self.title = title
        self.descriptionText = descriptionText
        self.isCompleted = isCompleted
    }
    
    
}
