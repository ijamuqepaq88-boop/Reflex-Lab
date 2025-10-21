import SwiftUI
import Combine

class TimedTapViewModel: ObservableObject {
    @AppStorage(SaveKey.perfectTimedTaps) var perfectTimedTaps: Int = 0

    @Published var indicatorPosition: CGFloat = 0
    @Published var feedbackMessage = ""
    @Published var score = 0
    @Published var currentRound = 1
    @Published var isCompleted = false
    @Published var isAnimating = false
    
    let totalRounds = 10
    private var timer: Timer?
    
    private let animationSpeed: CGFloat = 0.005
    private var animationDirection: CGFloat = 1
    
    private let targetZoneWidth: CGFloat = 0.2 // Zone will always be 20% of the bar width
    @Published var targetZoneStart: CGFloat = 0.7
    @Published var targetZoneEnd: CGFloat = 0.9
    
    private var timerInterval: TimeInterval {
        let baseInterval: TimeInterval = 0.020
        let minInterval: TimeInterval = 0.005
        let progressRatio = Double(currentRound - 1) / Double(totalRounds - 1)
        return baseInterval - (progressRatio * (baseInterval - minInterval))
    }
    
    var progress: Double {
        if totalRounds == 0 { return 0 }
        return Double(max(0, currentRound - 1)) / Double(totalRounds)
    }
    
    func startRound() {
        feedbackMessage = ""
        indicatorPosition = 0
        animationDirection = 1
        generateTargetZone()
        startAnimation()
    }
    
    private func generateTargetZone() {
        // Ensure the zone fits within the bounds (0.0 to 1.0)
        let maxStartPosition = 1.0 - targetZoneWidth
        targetZoneStart = CGFloat.random(in: 0.0...maxStartPosition)
        targetZoneEnd = targetZoneStart + targetZoneWidth
    }
    
    private func startAnimation() {
        isAnimating = true
        indicatorPosition = 0
        animationDirection = 1
        
        timer = Timer.scheduledTimer(withTimeInterval: timerInterval, repeats: true) { [weak self] _ in
            guard let self = self, self.isAnimating else { return }
            
            self.indicatorPosition += self.animationSpeed * self.animationDirection
            
            if self.indicatorPosition >= 1.0 {
                self.indicatorPosition = 1.0
                self.animationDirection = -1
            } else if self.indicatorPosition <= 0.0 {
                self.indicatorPosition = 0.0
                self.animationDirection = 1
            }
        }
    }
    
    func tapTarget() {
        isAnimating = false
        timer?.invalidate()
        
        if indicatorPosition >= targetZoneStart && indicatorPosition <= targetZoneEnd {
            perfectTimedTaps += 1
            feedbackMessage = "Perfect! Right in the zone!"
            score += 10
        } else if indicatorPosition >= targetZoneStart - 0.1 && indicatorPosition <= targetZoneEnd + 0.1 {
            feedbackMessage = "Close! Almost there!"
            score += 5
        } else if indicatorPosition < targetZoneStart {
            feedbackMessage = "Too Early!"
        } else {
            feedbackMessage = "Too Late!"
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.nextRound()
        }
    }
    
    private func nextRound() {
        if currentRound >= totalRounds {
            completeSession()
        } else {
            currentRound += 1
            indicatorPosition = 0
            startRound()
        }
    }
    
    private func completeSession() {
        isCompleted = true
        feedbackMessage = "Session Complete!"
        isAnimating = false
        timer?.invalidate()
    }
    
    func reset() {
        score = 0
        currentRound = 1
        isCompleted = false
        feedbackMessage = ""
        indicatorPosition = 0
        isAnimating = false
        animationDirection = 1
        targetZoneStart = 0.7
        targetZoneEnd = 0.9
        timer?.invalidate()
    }
}
