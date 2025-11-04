import SwiftUI

@available(iOS 15.0, *)
struct ColorMatchDrillView: View {
    @StateObject private var viewModel = ColorMatchViewModel()

    var body: some View {
        ZStack {
            contentView
            
            if viewModel.isCompleted {
                DrillCompleteView(score: viewModel.score, onTryAgain: {
                    viewModel.reset()
                    viewModel.startNewGoalRoundSequence()
                })
                .zIndex(1)
            }
        }
        .hideSystemNavBar()
        .animation(.default, value: viewModel.isCompleted)
        .onAppear {
            if !viewModel.isCompleted && viewModel.currentRound == 1 && viewModel.score == 0 { // Fresh start
                 viewModel.startNewGoalRoundSequence()
            }
        }
        .onDisappear {
            // Stop timer and clean up when view disappears
            viewModel.reset()
        }
    }
    
    private var contentView: some View {
        VStack(spacing: 15) {
            NavBar("Color Match", showBackButton: true)
            
            DrillGoalView(title: "Tap on figure in \(viewModel.currentGoalUIName.lowercased()) color") {
                Circle()
                    .fill(viewModel.currentGoalUIColor)
                    .frame(width: 40, height: 40)
                    .overlay(
                        Circle().stroke(Color.white.opacity(0.5), lineWidth: 1) // Optional border
                    )
            }
            .padding(.horizontal, 24)
            
            VStack {
                ZStack {
                    if !viewModel.feedbackMessage.isEmpty && !viewModel.isCompleted && (viewModel.shapeItems.first(where: {$0.isActiveShape}) == nil || true) {
                         Text(viewModel.feedbackMessage)
                            .font(.poppins(.regular, size: 14))
                            .foregroundStyle(.white)
                            .multilineTextAlignment(.center)
                    }
                }
                .frame(height: 40)


                if !viewModel.isCompleted {
                    VStack(spacing: 20) {
                        ForEach(0..<3, id: \.self) { row in
                            HStack(spacing: 30) {
                                ForEach(0..<2, id: \.self) { col in
                                    let itemIndex = row * 2 + col
                                    if viewModel.shapeItems.indices.contains(itemIndex) {
                                        let item = viewModel.shapeItems[itemIndex]
                                        Button {
                                            viewModel.userDidTap(tappedItemID: item.id)
                                        } label: {
                                            Image(item.shapeName)
                                                .resizable()
                                                .renderingMode(.template)
                                                .scaledToFit()
                                                .foregroundStyle(item.displayColor)
                                                .animation(.easeInOut(duration: 0.2), value: item.displayColor)
                                                .animation(.easeInOut(duration: 0.2), value: item.isActiveShape)
                                            
                                        }
                                        .frame(maxWidth: 70, maxHeight: 70)
                                    }
                                }
                            }
                        }
                    }
                    .padding()
                } else {
                     Spacer() // Takes up space if completed and DrillCompleteView is shown
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color("00396E")) // Dark panel blue
            )
            .padding(.horizontal, 24)

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
            
            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color("071F36"))
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color("FFD700"))
                        .frame(width: geo.size.width * viewModel.progress)
                }
            }
            .frame(height: 8)
            .padding(.horizontal, 24)
            .padding(.bottom, 30)
            .animation(.linear, value: viewModel.progress)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.mainBg.ignoresSafeArea())
    }
}
