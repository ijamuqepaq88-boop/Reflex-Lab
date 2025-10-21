import SwiftUI

struct FieldZone: Identifiable, Equatable {
    let id = UUID()
    var name: String
    var typicalActions: [String] // Could also be an enum or struct with icons
    var position: CGPoint // To define the tappable area on the field image
    var displayId: Int
}
