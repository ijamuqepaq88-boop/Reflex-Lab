import StoreKit
import SwiftUI

class StatsViewModel: ObservableObject {
    @AppStorage(SaveKey.correctColorMatches) var correctColorMatches: Int = 0
    @AppStorage(SaveKey.correctDirections) var correctDirections: Int = 0
    @AppStorage(SaveKey.perfectTimedTaps) var perfectTimedTaps: Int = 0
    @AppStorage(SaveKey.perfectTimerStops) var perfectTimerStops: Int = 0
    
    // Ball Drill Stats
    @AppStorage(SaveKey.ballDrillsViewed) var ballDrillsViewed: Int = 0
    @AppStorage(SaveKey.totalTimerSeconds) var totalTimerSeconds: Int = 0
    
    // Field Vision Stats
    @AppStorage(SaveKey.fieldZonesExplored) var fieldZonesExplored: Int = 0
    @AppStorage(SaveKey.totalZoneTapsStats) var totalZoneTapsStats: Int = 0
    
    func rateApp() {
        if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
            SKStoreReviewController.requestReview(in: scene)
        }
    }
    
    func shareApp() {
        guard let url = URL(string: "itms-apps:itunes.apple.com/us/app/apple-store/id\(Constants.appID)?mt=8&action=write-review") else { return }
        let items: [Any] = ["Check out this awesome app!", url]
        let activityViewController = UIActivityViewController(activityItems: items, applicationActivities: nil)
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            windowScene.windows.first?.rootViewController?.present(activityViewController, animated: true, completion: nil)
        }
    }
    
    func deleteAllData() {
        correctColorMatches = 0
        correctDirections = 0
        perfectTimedTaps = 0
        perfectTimerStops = 0
        ballDrillsViewed = 0
        totalTimerSeconds = 0
        fieldZonesExplored = 0
        totalZoneTapsStats = 0
    }
}
