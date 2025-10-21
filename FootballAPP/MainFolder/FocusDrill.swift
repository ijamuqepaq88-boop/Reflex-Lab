import Foundation

enum FocusDrill: Int, Identifiable, Equatable, CaseIterable, Codable {
    case directionTap = 1
    case colorMatch = 2
    case timedTap = 3
    case timerStop = 4
    
    var id: Int {
        return self.rawValue
    }
    
    var name: String {
        switch self {
        case .directionTap:
            return "Direction Tap"
        case .colorMatch:
            return "Color Match"
        case .timedTap:
            return "Timed Tap"
        case .timerStop:
            return "Timer Stop"
        }
    }
    
    var description: String {
        switch self {
        case .directionTap:
            return "Tap on arrow in right direction"
        case .colorMatch:
            return "Tap ONLY when the object is yellow"
        case .timedTap:
            return "Tap when the indicator is in the target zone"
        case .timerStop:
            return "Stop the timer by tapping at the right moment"
        }
    }
    
    var imageName: String {
        return "focus" + String(id)
    }
}
