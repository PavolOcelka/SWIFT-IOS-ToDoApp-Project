//
//  TimerSheet.swift
//  TodoApp
//
//  Created by Pavol Ocelka on 16/02/2025.
//

import SwiftUI

struct TimerSheet: View {
    @ObservedObject var timerManager: TimerManager
    @State private var timePicked: Int = 25
    @Environment(\.dismiss) var dismiss

    var body: some View {
        Form {
            if timerManager.isRunning || timerManager.isPaused == true {
                HStack {
                    Button("Stop Timer") {
                        timerManager.stopTimer()
                    }
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.red)
                    .clipShape(Capsule())
                    .buttonStyle(.plain)
                    
                    if timerManager.isPaused == false {
                        Button(action: timerManager.pauseTimer) {
                            Image(systemName: "pause")
                        }
                        .buttonStyle(.plain)
                    } else {
                        Button(action: timerManager.resumeTimer) {
                            Image(systemName: "play")
                        }
                        .buttonStyle(.plain)
                    }
                }
            } else {
                HStack {
                    Text("\(timePicked):00")
                    Stepper(value: $timePicked, in: 1...60, step: 1) {}
                }

                Button("Start Timer") {
                    timerManager.startTimer(minutes: timePicked)
                    dismiss()
                }
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.green)
                .clipShape(Capsule())
                .buttonStyle(.plain)
            }
        }
    }
}
#Preview {
    TimerSheet(timerManager: TimerManager())
}
