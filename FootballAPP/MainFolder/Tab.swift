import Foundation

enum Tab: String, Identifiable , CaseIterable {
    case focus = "Focus"
    case drills = "Drills"
    case vision = "Vision"
    case stats = "Stats"
    
    var icon: String {
        switch self {
        case .focus:
            return "tab0"
        case .drills:
            return "tab1"
        case .vision:
            return "tab2"
        case .stats:
            return "tab3"
        }
    }
    
    var id: Self { self }
}
