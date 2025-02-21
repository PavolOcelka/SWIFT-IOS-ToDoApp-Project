//
//  Task.swift
//  TodoApp
//
//  Created by Pavol Ocelka on 06/02/2025.
//

import SwiftData
import Foundation

@Model
class Task {
    var name: String
    var category: String
    var taskDescription: String
    
    init(name: String, category: String = "Personal", taskDescription: String = "") {
        self.name = name
        self.category = category
        self.taskDescription = taskDescription
    }
}
