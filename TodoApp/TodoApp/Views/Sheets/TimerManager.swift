//
//  TimerManager.swift
//  TodoApp
//
//  Created by Pavol Ocelka on 18/02/2025.
//

import Foundation
import SwiftUI

class TimerManager: ObservableObject {
    @Published var timeRemaining: Int = 0
    @Published var isRunning = false
    @Published var isFinished = false
    @Published var isBreak = false
    @Published var isPaused = false
    private var pausedTimeRemaining: Int?
    var endTime: Date?
    private var timer: Timer?

    func startTimer(minutes: Int, isBreak: Bool = false) {
        timeRemaining = minutes * 60
        notifyUser(seconds: minutes * 60)
        endTime = Date().addingTimeInterval(TimeInterval(timeRemaining + 1))
        isRunning = true
        isFinished = false
        self.isBreak = isBreak
        startUpdatingTime()
        
        
    }

    func stopTimer() {
        timeRemaining = 0
        timer?.invalidate()
        timer = nil
        isRunning = false
        isFinished = false
        isPaused = false
        endTime = nil
        isBreak = false
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["Timer"])
    }

    private func startUpdatingTime() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            self?.updateTime()
        }
    }

    private func updateTime() {
        guard let endTime = endTime else { return }
        let remaining = Int(endTime.timeIntervalSinceNow)
        if remaining > 0 {
            timeRemaining = remaining
        } else {
            timeRemaining = 0
            isRunning = false
            isFinished = true
            timer?.invalidate()
        }
    }

    func checkIfTimerShouldContinue() {
        guard let endTime = endTime else { return }
        let remaining = Int(endTime.timeIntervalSinceNow)
        if remaining > 0 {
            timeRemaining = remaining
            isRunning = true
            startUpdatingTime()
        } else {
            timeRemaining = 0
            isFinished = true
        }
    }

    func timeString() -> String {
        let minutes = timeRemaining / 60
        let seconds = timeRemaining % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    func pauseTimer() {
        guard isRunning else { return }
        timer?.invalidate()
        pausedTimeRemaining = timeRemaining
        isRunning = false
        isPaused = true
        
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["Timer"])
    }

    func resumeTimer() {
        guard let pausedTime = pausedTimeRemaining else { return }
        timeRemaining = pausedTime
        endTime = Date().addingTimeInterval(TimeInterval(timeRemaining + 1))
        isPaused = false
        isRunning = true
        notifyUser(seconds: timeRemaining)
        startUpdatingTime()
    }
    
    func notifyUser(seconds: Int) {
            let time = Date()
            let center = UNUserNotificationCenter.current()
            let content = UNMutableNotificationContent()
            
            if let resumeTime = Calendar.current.date(byAdding: .minute, value: 5, to: time) {
                let formatter = DateFormatter()
                formatter.timeStyle = .short
                
                let resumeTimeString = formatter.string(from: resumeTime)
                
                content.title = "Time's Up!"
                content.body = "Get a 5 minute break and start again at \(resumeTimeString)"
                content.sound = UNNotificationSound.default
                
                let triger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(seconds), repeats: false)
                
                let request = UNNotificationRequest(identifier: "Timer", content: content, trigger: triger)
                
                center.add(request) { error in
                    if let error = error {
                        print(error)
                    } else {
                        print("Scheduled")
                    }
                }
                
                
            } else {
                print("Failed to create notifiation")
            }
        
    }
}

