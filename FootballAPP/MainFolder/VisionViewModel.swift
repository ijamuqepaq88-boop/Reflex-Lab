import SwiftUI
import Combine

class VisionViewModel: ObservableObject {
    @Published var fieldZones: [FieldZone] = FieldZone.sampleZones // Load actual data
    @Published var selectedZone: FieldZone?
    
    @AppStorage(SaveKey.fieldZonesExplored) private var fieldZonesExplored: Int = 0
    @AppStorage(SaveKey.totalZoneTapsStats) private var totalZoneTapsStats: Int = 0
    
    @Published var exploredZoneIds: Set<UUID> = []
    
    // Stats related
    @Published var exploredZonesCount: Int = 0 // Unique zones tapped
    @Published var totalZoneTaps: Int = 0

    func selectZone(_ zone: FieldZone) {
        if selectedZone != zone {
            selectedZone = zone
            if !exploredZoneIds.contains(zone.id) {
                exploredZoneIds.insert(zone.id)
                fieldZonesExplored += 1
                exploredZonesCount = fieldZonesExplored
            }
        }
        totalZoneTapsStats += 1
        totalZoneTaps = totalZoneTapsStats
    }

    func deselectZone() {
        selectedZone = nil
    }
    
    init() {
        self.exploredZonesCount = fieldZonesExplored
        self.totalZoneTaps = totalZoneTapsStats
    }
}
