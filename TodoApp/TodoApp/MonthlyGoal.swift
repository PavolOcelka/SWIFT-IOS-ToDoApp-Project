//
//  MonthlyGoal.swift
//  TodoApp
//
//  Created by Pavol Ocelka on 06/02/2025.
//

import Foundation
import SwiftData

@Model
class MonthlyGoal {
    var title: String
    var descriptionText: String
    
    init(title: String, descriptionText: String = "") {
        self.title = title
        self.descriptionText = descriptionText
    }
}
