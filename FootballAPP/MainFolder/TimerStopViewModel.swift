import SwiftUI
import Combine

class TimerStopViewModel: ObservableObject {
    @AppStorage(SaveKey.perfectTimerStops) var perfectTimerStops: Int = 0

    @Published var timerValue: Double = 0.0
    @Published var isRunning = false
    @Published var feedbackMessage = ""
    @Published var score = 0
    @Published var currentRound = 1
    @Published var isCompleted = false
    @Published var targetTime: Double = 10.0

    let totalRounds = 10
    private var timer: Timer?

    var progress: Double {
        if totalRounds == 0 { return 0 }
        return Double(max(0, currentRound - 1)) / Double(totalRounds)
    }
    
    func startRound() {
        feedbackMessage = ""
        timerValue = 0.0
        isRunning = false
        targetTime = Double.random(in: 5.0...15.0)
    }

    func startTimer() {
        isRunning = true
        timerValue = 0.0

        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
            DispatchQueue.main.async {
                self.timerValue += 0.01
            }
        }
    }

    func stopTimer() {
        isRunning = false
        timer?.invalidate()

        let difference = abs(timerValue - targetTime)

        if difference <= 0.05 {
            perfectTimerStops += 1
            feedbackMessage = "Perfect! \(String(format: "%.2f", timerValue))s"
            score += 15
        } else if difference <= 0.15 {
            feedbackMessage = "Great! \(String(format: "%.2f", timerValue))s"
            score += 10
        } else if difference <= 0.30 {
            feedbackMessage = "Good! \(String(format: "%.2f", timerValue))s"
            score += 5
        } else if timerValue < targetTime {
            feedbackMessage = "Too Early! \(String(format: "%.2f", timerValue))s"
        } else {
            feedbackMessage = "Too Late! \(String(format: "%.2f", timerValue))s"
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.nextRound()
        }
    }

    private func nextRound() {
        if currentRound >= totalRounds {
            completeSession()
        } else {
            currentRound += 1
            startRound()
        }
    }

    private func completeSession() {
        isCompleted = true
        feedbackMessage = "Session Complete!"
        timer?.invalidate()
    }

    func reset() {
        score = 0
        currentRound = 1
        isCompleted = false
        feedbackMessage = ""
        timerValue = 0.0
        isRunning = false
        timer?.invalidate()
        targetTime = Double.random(in: 5.0...15.0)
    }

    var maxXPForSession: Int {
        totalRounds * 15 // Max score per round is 15
    }
}
