//
//  TodoAppApp.swift
//  TodoApp
//
//  Created by Pavol Ocelka on 06/02/2025.
//

import SwiftData
import SwiftUI

@main
struct TodoApp: App {
    
    init() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .badge, .sound]) { result, error in
            if let error = error {
                print(error)
            }}
    }
        
    let container: ModelContainer = {
        do {
            let schema = Schema([Task.self, WeeklyGoal.self, MonthlyGoal.self, GoalPart.self, Goal.self, BrainDumpModel.self, Idea.self])
            let container = try ModelContainer(for: schema, configurations: [])
            return container
        } catch {
            fatalError(error.localizedDescription)
        }
    }()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(container)
        }
    }
}
