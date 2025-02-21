//
//  TimerManager.swift
//  TodoApp
//
//  Created by Pavol Ocelka on 18/02/2025.
//

import Foundation

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
        endTime = nil
        isBreak = false
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
    }

    func resumeTimer() {
        guard let pausedTime = pausedTimeRemaining else { return }
        timeRemaining = pausedTime
        endTime = Date().addingTimeInterval(TimeInterval(timeRemaining + 1))
        isPaused = false
        isRunning = true
        startUpdatingTime()
    }
}

