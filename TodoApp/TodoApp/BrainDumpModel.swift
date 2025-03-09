//
//  BrainDumpModel.swift
//  TodoApp
//
//  Created by Pavol Ocelka on 16/02/2025.
//

import Foundation
import SwiftData

@Model
final class BrainDumpModel: Identifiable {
    var id = UUID()
    var title: String
    var text: String
    var date: Date
    
    init(title: String, text: String, date: Date) {
        self.title = title
        self.text = text
        self.date = date
    }
}
