//
//  ContentView.swift
//  TodoApp
//
//  Created by Pavol Ocelka on 06/02/2025.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    
    @AppStorage("wasShown") private var wasShown: Bool = false
    
    
    @Environment(\.modelContext) var context
    
    @Query var weeklyGoal: [WeeklyGoal]
    @Query var monthlyGoal: [MonthlyGoal]
    @Query var mainGoal: [Goal]
    @Query var tasks: [Task]
    
    @State private var activeSheet: ActiveSheet? = nil
    @StateObject private var timerManager = TimerManager()
    
    var body: some View {
        NavigationStack {
            if !wasShown {
                TutorialView(wasShown: $wasShown)
            }
            else {
                ZStack {
                    Color.black.ignoresSafeArea()
                    VStack {
                        HStack {
                            Text("Goals")
                                .font(.largeTitle.bold())
                                .foregroundStyle(.white)
                                .padding(.horizontal)
                            Spacer()
                            Text(timerManager.timeString() == "00:00" ? "" : timerManager.timeString())
                                .foregroundStyle(.white)
                                .padding(.horizontal)
                                .font(.title)
                        }
                        Spacer()
                    }
                    
                    
                    VStack (spacing: 0){
                        TabView {
                            Tab {
                                NavigationLink(destination: GoalView()) {
                                    VStack {
                                        Text("My Goal")
                                            .foregroundStyle(.white).opacity(0.5)
                                            .font(.title2)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .padding(.horizontal)
                                        Text(mainGoal.isEmpty ? "Set up your goal" : mainGoal.first?.title ?? "Set up your goal")
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .foregroundStyle(.white)
                                            .font(.title)
                                            .padding(.horizontal)
                                        
                                    }
                                    .frame(maxWidth: .infinity, maxHeight: 100)
                                    .background(LinearGradient.elementGradient3)
                                    .clipShape(RoundedRectangle(cornerRadius: 15))
                                    
                                }
                                .padding(.horizontal)
                            }
                            
                            Tab {
                                if !weeklyGoal.isEmpty {
                                    NavigationLink(destination: WeeklyGoalView(weeklyGoal: weeklyGoal.first!)) {
                                        VStack {
                                            Text("Weekly Goal")
                                                .foregroundStyle(.white).opacity(0.5)
                                                .font(.title2)
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                                .padding(.horizontal)
                                            Text(weeklyGoal.first?.title ?? "Set up new weekly goal")
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                                .foregroundStyle(.white)
                                                .font(.title)
                                                .padding(.horizontal)
                                            
                                        }
                                        .frame(maxWidth: .infinity, maxHeight: 100)
                                        .background(LinearGradient.elementGradient)
                                        .clipShape(RoundedRectangle(cornerRadius: 15))
                                        
                                    }
                                    .padding(.horizontal)
                                } else {
                                    Button(action: {
                                        activeSheet = .weeklyGoalSheet
                                    }){
                                        VStack {
                                            Text("Weekly Goal")
                                                .foregroundStyle(.white).opacity(0.5)
                                                .font(.title2)
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                                .padding(.horizontal)
                                            Text("Set up ")
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                                .foregroundStyle(.white)
                                                .font(.title)
                                                .padding(.horizontal)
                                            
                                        }
                                        .frame(maxWidth: .infinity, maxHeight: 100)
                                        .background(LinearGradient.elementGradient)
                                        .clipShape(RoundedRectangle(cornerRadius: 15))
                                    }
                                    .padding(.horizontal)
                                }
                            }
                            
                            Tab {
                                if !monthlyGoal.isEmpty {
                                    NavigationLink(destination: MonthlyGoalView(monthlyGoal: monthlyGoal.first!)) {
                                        VStack {
                                            Text("Monthly Goal")
                                                .foregroundStyle(.white).opacity(0.5)
                                                .font(.title2)
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                                .padding(.horizontal)
                                            Text(monthlyGoal.first?.title ?? "Set up")
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                                .foregroundStyle(.white)
                                                .font(.title)
                                                .padding(.horizontal)
                                            
                                        }
                                        .frame(maxWidth: .infinity, maxHeight: 100)
                                        .background(LinearGradient.elementGradient2)
                                        .clipShape(RoundedRectangle(cornerRadius: 15))
                                        
                                    }
                                    .padding(.horizontal)
                                } else {
                                    Button(action: {
                                        activeSheet = .monthlyGoalSheet
                                    }){
                                        VStack {
                                            Text("Monthly Goal")
                                                .foregroundStyle(.white).opacity(0.5)
                                                .font(.title2)
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                                .padding(.horizontal)
                                            Text("Set up")
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                                .foregroundStyle(.white)
                                                .font(.title)
                                                .padding(.horizontal)
                                            
                                        }
                                        .frame(maxWidth: .infinity, maxHeight: 100)
                                        .background(LinearGradient.elementGradient2)
                                        .clipShape(RoundedRectangle(cornerRadius: 15))
                                    }
                                    .padding(.horizontal)
                                }
                                
                            }
                            
                        }
                        .frame(height: 220)
                        .tabViewStyle(.page)
                        .scrollContentBackground(.hidden)
                        
                        HStack {
                            Text("ToDos")
                                .font(.largeTitle.bold())
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .foregroundStyle(.white)
                                .padding(.horizontal)
                            Button(action: {
                                activeSheet = .taskSheet
                            }){
                                Image(systemName: "plus.circle")
                                    .resizable()
                                    .foregroundStyle(.white)
                                    .scaledToFit()
                                    .frame(width: 30, height: 30)
                                    .padding(.horizontal)
                            }
                        }
                        List {
                            ForEach(tasks, id: \.self) { task in
                                NavigationLink(destination: TaskDetailView(task: task)){
                                    VStack {
                                        Text(task.name == "" ? "Untitled" : task.name)
                                            .font(.headline.bold())
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                        Text(task.category)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .font(.caption)
                                            .foregroundStyle(.secondary)
                                    }
                                }
                            }
                            .onDelete(perform: deleteTask)
                        }
                        .frame(maxHeight: 350)
                        .scrollContentBackground(.hidden)
                        
                        Rectangle()
                            .frame(maxWidth: .infinity, maxHeight: 1)
                            .foregroundStyle(.secondary)
                            .padding(.horizontal)
                        
                        VStack(alignment: .leading){
                            Text("Tools")
                                .font(.title2.bold())
                                .foregroundStyle(.white)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            HStack(spacing: 30) {
                                Button(action: {activeSheet = .timerSheet}) {
                                    Image(systemName: "clock.badge")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 50, height: 50)
                                        .foregroundStyle(.white)
                                    
                                }
                                NavigationLink(destination: BrainDumpView()) {
                                    Image(systemName: "brain.filled.head.profile")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 50, height: 50)
                                        .foregroundStyle(.white)
                                }
                                NavigationLink(destination: IdeasView()){
                                    Image(systemName: "lightbulb.max")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 50, height: 50)
                                        .foregroundStyle(.white)
                                }
                                NavigationLink(destination: QuotesView()){
                                    Image(systemName: "quote.closing")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 50, height: 50)
                                        .foregroundStyle(.white)
                                }
                            }
                        }
                        .padding()
                        Spacer()
                        
                    }
                }
                
                .sheet(item: $activeSheet) { item in
                    switch item {
                    case .taskSheet:
                        CreateNewTaskSheet()
                            .presentationDetents([.height(200)])
                    case .weeklyGoalSheet:
                        CreateWeeklyGoalSheet()
                            .presentationDetents([.height(200)])
                    case .monthlyGoalSheet:
                        CreateMonthlyGoalSheet()
                            .presentationDetents([.height(200)])
                    case .timerSheet:
                        TimerSheet(timerManager: timerManager)
                            .presentationDetents([.height(200)])
                        
                    }
                }
            }
        }
    }
    
    func deleteTask(at offsets: IndexSet) {
        for index in offsets {
            let taskToDelete = tasks[index]
            context.delete(taskToDelete)
        }
        
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
    
    enum ActiveSheet: Identifiable {
        case taskSheet
        case weeklyGoalSheet
        case monthlyGoalSheet
        case timerSheet
        
        var id: Int {hashValue}
    }
}


#Preview {
    ContentView()
}
