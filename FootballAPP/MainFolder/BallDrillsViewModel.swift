import SwiftUI
import Combine

class BallDrillsViewModel: ObservableObject {
    @Published var timerValue: Int = 0
    @Published var isTimerRunning: Bool = false
    private var timerSubscription: AnyCancellable?
    
    @AppStorage(SaveKey.ballDrillsViewed) private var ballDrillsViewed: Int = 0
    @AppStorage(SaveKey.totalTimerSeconds) private var totalTimerSeconds: Int = 0
    
    func startTimer() {
        isTimerRunning = true
        timerSubscription = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.timerValue += 1
            }
    }

    func pauseTimer() {
        isTimerRunning = false
        timerSubscription?.cancel()
    }

    func resetTimer() {
        isTimerRunning = false
        timerSubscription?.cancel()
        timerValue = 0
    }
    

    func drillViewed(_ drill: BallDrill) {
            ballDrillsViewed += 1
    }
    
    func addTimerUsage(_ seconds: Int) {
        totalTimerSeconds += seconds
        resetTimer()
    }
    
    func stopTimerAndSave() {
        if isTimerRunning {
            addTimerUsage(timerValue)
        }
        resetTimer()
    }
}
