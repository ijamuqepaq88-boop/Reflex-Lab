import SwiftUI
import Combine

enum MatchColor: String, CaseIterable, Identifiable {
    case yellow, red, green, blue, purple, orange

    var id: String { self.rawValue }

    var color: Color {
        switch self {
        case .yellow: return .yellow
        case .red: return .red
        case .green: return .green
        case .blue: return .blue
        case .purple: return .purple
        case .orange: return .orange
        }
    }

    var name: String {
        return self.rawValue.prefix(1).capitalized + self.rawValue.dropFirst()
    }
}

struct ShapeDisplayItem: Identifiable {
    let id = UUID()
    var shapeName: String
    var displayColor: Color
    var isActiveShape: Bool = false
}

class ColorMatchViewModel: ObservableObject {
    @Published var shapeItems: [ShapeDisplayItem] = []
    
    @Published var currentGoalEnum: MatchColor = .yellow
    
    @Published var feedbackMessage = ""
    @Published var score = 0
    @Published var currentRound = 1
    @Published var isCompleted = false
    @Published var progress: CGFloat = 0.0
    
    @AppStorage(SaveKey.correctColorMatches) private var correctColorMatches: Int = 0
    
    let totalRounds = 5
    let pointsPerRound = 10

    private let activeShapeDisplayColors: [Color]
    private let inactiveColor = Color("1B6AA3")
    private let allShapeNames: [String] = (1...6).map { "shape" + String($0) }
    
    private var interactionTimer: Timer?
    private let interactionInterval: TimeInterval = 1.2
    private var currentActiveShapeItemIndex: Int? = nil

    init() {
        // Populate activeShapeDisplayColors: all MatchColor enum colors + extra display colors
        var displayColors = MatchColor.allCases.map { $0.color }
        displayColors.append(contentsOf: [.pink, .cyan, .gray, self.inactiveColor])
        self.activeShapeDisplayColors = displayColors.shuffled()

        self.shapeItems = allShapeNames.map { ShapeDisplayItem(shapeName: $0, displayColor: self.inactiveColor) }
        
        // Set initial goal enum if needed, though startNewGoalRoundSequence will also set it.
        // self.currentGoalEnum = MatchColor.allCases.randomElement() ?? .yellow
    }

    // Derived properties for current goal's color and name
    var currentGoalUIColor: Color { currentGoalEnum.color }
    var currentGoalUIName: String { currentGoalEnum.name }

    func startNewGoalRoundSequence() {
        guard !isCompleted else { return }

        if currentRound > totalRounds {
            completeSession()
            return
        }
        
        var newGoalEnum = MatchColor.allCases.randomElement()!
        if MatchColor.allCases.count > 1 {
            var attempts = 0
            // Try to pick a different color from the current one
            while newGoalEnum == currentGoalEnum && attempts < MatchColor.allCases.count * 2 {
                newGoalEnum = MatchColor.allCases.randomElement()!
                attempts += 1
            }
        }
        currentGoalEnum = newGoalEnum
        
        feedbackMessage = ""
        updateProgress()
        prepareAndStartInteractionCycle()
    }
    
    private func prepareAndStartInteractionCycle() {
        interactionTimer?.invalidate()
        activateRandomShape()
        interactionTimer = Timer.scheduledTimer(withTimeInterval: interactionInterval, repeats: true) { [weak self] _ in
            self?.activateRandomShape()
        }
    }

    private func activateRandomShape() {
        guard !shapeItems.isEmpty else { return }
        for i in shapeItems.indices {
            shapeItems[i].isActiveShape = false
            shapeItems[i].displayColor = inactiveColor
        }
        let newActiveIndex = Int.random(in: 0..<shapeItems.count)
        currentActiveShapeItemIndex = newActiveIndex
        shapeItems[newActiveIndex].isActiveShape = true
        shapeItems[newActiveIndex].displayColor = activeShapeDisplayColors.randomElement() ?? .gray
    }
    
    func userDidTap(tappedItemID: UUID) {
        guard let tappedItemIndex = shapeItems.firstIndex(where: { $0.id == tappedItemID }) else { return }
        interactionTimer?.invalidate()
        let item = shapeItems[tappedItemIndex]

        if item.isActiveShape && item.displayColor == currentGoalEnum.color {
            correctColorMatches += 1
            feedbackMessage = "Correct! You found \(currentGoalEnum.name.lowercased())."
            score += pointsPerRound
        } else {
            var reason = ""
            if !item.isActiveShape {
                reason = "That shape wasn't the active one."
            } else {
                reason = "That was \(item.displayColor.description.lowercased()), not \(currentGoalEnum.name.lowercased())."
            }
            feedbackMessage = "Oops! \(reason)"
        }
        
        currentRound += 1
        
        if currentRound > totalRounds {
            completeSession()
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [weak self] in
                self?.startNewGoalRoundSequence()
            }
        }
        
        updateProgress()
    }
    
    private func completeSession() {
        interactionTimer?.invalidate()
        isCompleted = true
        for i in shapeItems.indices {
            shapeItems[i].isActiveShape = false
            shapeItems[i].displayColor = inactiveColor
        }
        feedbackMessage = "Drill Complete! Final Score: \(score)"
    }
    
    func reset() {
        interactionTimer?.invalidate()
        score = 0
        currentRound = 1
        isCompleted = false
        feedbackMessage = ""
        progress = 0.0
        self.shapeItems = allShapeNames.map { ShapeDisplayItem(shapeName: $0, displayColor: inactiveColor) }
        currentActiveShapeItemIndex = nil
        // currentGoalEnum will be set by the first call to startNewGoalRoundSequence
    }

    private func updateProgress() {
        if totalRounds > 0 {
            let completedRounds = CGFloat(currentRound - 1)
            progress = completedRounds / CGFloat(totalRounds)
        } else {
            progress = 0
        }
        progress = min(max(progress, 0.0), 1.0)
    }
}
