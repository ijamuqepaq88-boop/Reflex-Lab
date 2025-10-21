import SwiftUI
import Combine

class DirectionTapViewModel: ObservableObject {
    @AppStorage(SaveKey.correctDirections) var correctDirections: Int = 0

    @Published var currentDirection: ArrowDirection = .up
    @Published var feedbackMessage = ""
    @Published var score = 0
    @Published var currentRound = 1
    @Published var isCompleted = false
    @Published var showArrow = true
    @Published var selectedDirection: ArrowDirection? = nil
    
    let totalRounds = 10
    
    var progress: Double {
        return Double(currentRound - 1) / Double(totalRounds)
    }
    
    enum ArrowDirection: String, CaseIterable {
        case up
        case down
        case left
        case right
        
        var displayName: String {
            switch self {
            case .up: return "UP"
            case .down: return "DOWN"
            case .left: return "LEFT"
            case .right: return "RIGHT"
            }
        }
        
        var imageName: String {
            return "direction" + self.rawValue.capitalized
        }
    }
    
    func startRound() {
        feedbackMessage = ""
        showArrow = true
        selectedDirection = nil
        generateNewDirection()
    }
    
    private func generateNewDirection() {
        currentDirection = ArrowDirection.allCases.randomElement() ?? .up
    }
    
    func tapDirection(_ direction: ArrowDirection) {
        selectedDirection = direction
        
        if direction == currentDirection {
            correctDirections += 1
            feedbackMessage = "Correct Direction!"
            score += 10
        } else {
            feedbackMessage = "Wrong Direction! It was \(currentDirection.displayName)"
        }
        
        showArrow = false
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
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
    }
    
    func reset() {
        score = 0
        currentRound = 1
        isCompleted = false
        feedbackMessage = ""
        showArrow = true
        selectedDirection = nil
    }
}
