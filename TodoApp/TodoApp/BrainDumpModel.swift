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
    
    init(title: String, text: String) {
        self.title = title
        self.text = text
    }
}
