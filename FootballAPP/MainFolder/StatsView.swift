import SwiftUI

struct StatsView: View {
    @StateObject private var viewModel = StatsViewModel()
    @State private var showingDeleteConfirm = false
    
    var body: some View {
        VStack(spacing: 10) {
            NavBar("Stats & Setting")
            
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    statsSection(title: "Focus Drill Stats", stats: focusDrillStats())
                    statsSection(title: "Ball Drill Stats", stats: ballDrillStats())
                    statsSection(title: "Field Vision Stats", stats: fieldVisionStats())
                    
                    settingsSection()
                }
                .padding(.bottom, 30)
            }
        }
        .background {
            Color.mainBg.ignoresSafeArea()
        }
        .alert("Delete All Data?", isPresented: $showingDeleteConfirm) {
            Button("Delete", role: .destructive) {
                viewModel.deleteAllData()
            }
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("Are you sure you want to delete all your progress and statistics? This action cannot be undone.")
        }
    }
    
    private func focusDrillStats() -> [StatItem] {
        return [
            StatItem(name: "Correct Color Matches", value: "\(viewModel.correctColorMatches)"),
            StatItem(name: "Correct Directions", value: "\(viewModel.correctDirections)"),
            StatItem(name: "Perfect Timed Taps", value: "\(viewModel.perfectTimedTaps)"),
            StatItem(name: "Perfect Timer Stops", value: "\(viewModel.perfectTimerStops)")
        ]
    }
    
    private func ballDrillStats() -> [StatItem] {
        return [
            StatItem(name: "Ball Drills Viewed", value: "\(viewModel.ballDrillsViewed)"),
            StatItem(name: "Total Timer Minutes", value: "\(Int(Double(viewModel.totalTimerSeconds) / 60))")
        ]
    }
    
    private func fieldVisionStats() -> [StatItem] {
        return [
            StatItem(name: "Field Zones Explored", value: "\(viewModel.fieldZonesExplored)"),
            StatItem(name: "Total Zone Taps", value: "\(viewModel.totalZoneTapsStats)")
        ]
    }
    
    @ViewBuilder
    private func statsSection(title: String, stats: [StatItem]) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.poppins(.bold, size: 18))
                .foregroundStyle(.white)
                .padding(.horizontal, 30)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(stats) { stat in
                        statCard(title: stat.name, value: stat.value)
                    }
                }
                .padding(.horizontal, 28)
            }
        }
    }
    
    @ViewBuilder
    private func statCard(title: String, value: String) -> some View {
        VStack(spacing: 5) {
            Text(title)
                .font(.poppins(.medium, size: 13))
                .frame(maxWidth: .infinity)
                .multilineTextAlignment(.center)
                .frame(height: 40)
            
            Text(value)
                .font(.poppins(.bold, size: 45))
        }
        .foregroundStyle(.white)
        .padding(.horizontal, 10)
        .frame(width: 140, height: 120)
        .background {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.white.opacity(0.1))
                RoundedRectangle(cornerRadius: 10)
                    .strokeBorder(Color.white.opacity(0.2), lineWidth: 1)
            }
        }
    }
    
    @ViewBuilder
    private func settingsSection() -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Settings")
                .font(.poppins(.bold, size: 18))
                .foregroundStyle(.white)
                .padding(.horizontal, 30)
            
            VStack(spacing: 8) {
                HStack(spacing: 1) {
                    settingsButton(title: "Rate App", icon: .rate, action: viewModel.rateApp)
                    settingsButton(title: "Share App", icon: .share, action: viewModel.shareApp)
                }
                
                deleteDataButton
                
                Link(destination: Constants.privacyPolicy) {
                    Text("Privacy Policy")
                        .font(.montserrat(.medium, size: 16))
                        .foreground("F9FEFE")
                        .frame(height: 24)
                }
            }
            .padding(.horizontal, 28)
        }
    }
    
    @ViewBuilder
    private func settingsButton(title: String, icon: ImageResource, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            HStack(spacing: 10) {
                Image(icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                
                Text(title)
                    .font(.montserrat(.medium, size: 16))
                    .foreground("F9FEFE")
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.horizontal, 20)
            .frame(height: 62)
            .background {
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color("153453"))
                    RoundedRectangle(cornerRadius: 8)
                        .strokeBorder(Color("F9FEFE").opacity(0.1), lineWidth: 1)
                }
            }
        }
    }
    
    private var deleteDataButton: some View {
        Button {
            showingDeleteConfirm = true
        } label: {
            HStack(spacing: 10) {
                Image(.trash)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                
                Text("Delete All Data")
                    .font(.montserrat(.medium, size: 16))
                    .foreground("EF4444")
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Image(.chevronRight)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 14)
            }
            .padding(.horizontal, 20)
            .frame(height: 62)
            .background {
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color("153453"))
                    RoundedRectangle(cornerRadius: 8)
                        .strokeBorder(Color("F9FEFE").opacity(0.1), lineWidth: 1)
                }
            }
        }
    }
    
    struct StatItem: Identifiable {
        let id = UUID()
        let name: String
        let value: String
    }
}

#Preview {
    StatsView()
}
