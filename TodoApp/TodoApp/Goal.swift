//
//  Goal.swift
//  TodoApp
//
//  Created by Pavol Ocelka on 07/02/2025.
//

import Foundation
import SwiftData

@Model
class Goal {
    var title: String
    var descriptionText: String
    var parts: Int
    var progress: Float = 0
    
    init(title: String, descriptionText: String = "", parts: Int) {
        self.title = title
        self.descriptionText = descriptionText
        self.parts = parts
    }
}
