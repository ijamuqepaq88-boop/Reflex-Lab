import SwiftUI

@available(iOS 15.0, *)
struct TimedTapDrillView: View {
    @StateObject private var viewModel = TimedTapViewModel()
    // Environment dismiss is implicitly used by NavBar and DrillCompleteView

    var body: some View {
        ZStack {
            contentView
            
            if viewModel.isCompleted {
                DrillCompleteView(score: viewModel.score, onTryAgain: {
                    viewModel.reset()
                    viewModel.startRound()
                })
                .zIndex(1) // Ensure it's on top
            }
        }
        .hideSystemNavBar()
        .animation(.default, value: viewModel.isCompleted) // Animate completion view appearance
        .onAppear {
            viewModel.startRound()
        }
        .background(Color.mainBg.ignoresSafeArea()) // Apply background to the entire ZStack
    }
    
    private var contentView: some View {
        VStack(spacing: 15) {
            NavBar("Timed Tap", showBackButton: true)
            
            DrillGoalView(title: "Tap on central zone") {
                ZStack {
                    Circle().fill(Color("007BFF").opacity(0.8)).frame(width: 44, height: 44) // Blue outer
                    Circle().fill(Color("FFD700")).frame(width: 20, height: 20) // Yellow inner
                }
            }
            .padding(.horizontal, 24)
            
            // Main Interaction Area
            Group {
                if !viewModel.feedbackMessage.isEmpty && !viewModel.isAnimating {
                    feedbackDisplayView
                } else { // Show game if animating or if feedback is empty (initial state)
                    gameInteractionView
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background {
                ZStack {
                    RoundedRectangle(cornerRadius: 15).fill(Color("00396E")) // Dark blue card bg
                    RoundedRectangle(cornerRadius: 15).strokeBorder(Color("007BFF")) // Card border
                }
            }
            .padding(.horizontal, 24)
            
            gameInfoView
            
            xpBarView
                .padding(.horizontal, 24)
                .padding(.bottom, 30)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        // Removed .background modifier here, applied to ZStack in body
    }

    private var gameInteractionView: some View {
        VStack(spacing: 20) {
            Text("Tap when the indicator hits the yellow zone!")
                .font(.title3) // Consider using AppFonts if available
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding(.top, 30)

            Spacer()

            let barWidth: CGFloat = UIScreen.main.bounds.width * 0.7 // Responsive bar width
            let indicatorWidth: CGFloat = 25

            ZStack(alignment: .leading) {
                // Background track
                Capsule()
                    .fill(Color.blue.opacity(0.5)) // Slightly more subtle track
                    .frame(height: 20)

                // Target zone (Yellow)
                let targetZoneVisualStart = barWidth * viewModel.targetZoneStart
                let targetZoneVisualWidth = barWidth * (viewModel.targetZoneEnd - viewModel.targetZoneStart)
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color("FFD700")) // Yellow from assets
                    .frame(width: targetZoneVisualWidth, height: 20)
                    .offset(x: targetZoneVisualStart)
                
                // Moving indicator (Triangle)
                Image(.timedIndicator)
                    .resizable()
                    .scaledToFit()
                    .frame(width: indicatorWidth, height: indicatorWidth)
                    .foregroundColor(Color.white.opacity(0.85)) // Brighter triangle
                    .offset(y: 28) // Positioned below the bar
                    // Calculate offset for the triangle's center to align with indicatorPosition on the bar
                    .offset(x: (viewModel.indicatorPosition * barWidth) - (indicatorWidth / 2) )
            }
            .frame(width: barWidth, height: 55) // Increased height for indicator visibility

            Spacer()
            
            Button("Stop") {
                viewModel.tapTarget()
            }
            .buttonStyle(MainButtonStyle()) // Assuming MainButtonStyle provides a full-width blue button
            .padding(.horizontal, 40) // Give button some horizontal padding if not full width by style
            .padding(.bottom, 30)
        }
        .padding() // Padding inside the blue bordered box
    }
    
    private var feedbackDisplayView: some View {
        VStack {
            Spacer()
            Text(viewModel.feedbackMessage)
                .font(.system(size: 42, weight: .bold)) // Prominent feedback
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding()
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    private var gameInfoView: some View {
        HStack {
            Text("Round \(viewModel.currentRound)/\(viewModel.totalRounds)")
                .font(.poppins(.semiBold, size: 16))
                .foregroundStyle(.white)
            
            Spacer()

            Text("Score: \(viewModel.score)")
                .font(.poppins(.semiBold, size: 16))
                .foregroundStyle(.white)
        }
        .padding(.horizontal, 24)
    }
    
    private var xpBarView: some View {
        GeometryReader { geo in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 4).fill(Color("071F36"))
                RoundedRectangle(cornerRadius: 4).fill(Color("FFD700"))
                    .frame(width: max(0, geo.size.width * viewModel.progress)) // Ensure width is not negative
            }
        }
        .frame(height: 8)
        .animation(.default, value: viewModel.progress) // Animate progress changes
    }
}

