import SwiftUI

struct DirectionTapDrillView: View {
    @StateObject private var viewModel = DirectionTapViewModel()
    
    var body: some View {
        ZStack {
            contentView
            
            if viewModel.isCompleted {
                DrillCompleteView(score: viewModel.score, onTryAgain: {
                    viewModel.reset()
                    viewModel.startRound()
                })
                .zIndex(1)
            }
        }
        .hideSystemNavBar()
        .animation(.default, value: viewModel.isCompleted)
        .onAppear {
            viewModel.startRound()
        }
    }
    
    private var contentView: some View {
        VStack(spacing: 15) {
            NavBar("Direction Tap", showBackButton: true)
            
            DrillGoalView(title: "Tap on arrow in right direction") {
                ZStack {
                    Circle()
                        .fill(Color("007BFF").opacity(0.8))
                    
                    Image(viewModel.currentDirection.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                }
            }
            .padding(.horizontal, 24)
            
            VStack(spacing: 0) {
                directionButton(for: .up)
                
                HStack(spacing: 50) {
                    directionButton(for: .left)
                    directionButton(for: .right)
                }
                
                directionButton(for: .down)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background {
                ZStack {
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color("00396E"))
                    RoundedRectangle(cornerRadius: 15)
                        .strokeBorder(Color("007BFF"))
                }
            }
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
                ZStack {
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color("071F36"))
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color("FFD700"))
                        .frame(width: geo.size.width * viewModel.progress)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .frame(height: 8)
            .padding(.horizontal, 24)
            .padding(.bottom, 30)
            .animation(.default, value: viewModel.progress)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            Color.mainBg.ignoresSafeArea()
        }
    }
    
    private func directionButton(for direction: DirectionTapViewModel.ArrowDirection) -> some View {
        Button {
            viewModel.tapDirection(direction)
        } label: {
            Image(direction.imageName)
                .resizable()
                .renderingMode(.template)
                .scaledToFit()
                .frame(width: 80, height: 80)
                .foregroundStyle(getArrowColor(for: direction))
        }
        .disabled(viewModel.selectedDirection != nil)
    }
    
    private func getArrowColor(for direction: DirectionTapViewModel.ArrowDirection) -> Color {
        if let selectedDirection = viewModel.selectedDirection {
            return selectedDirection == direction ? Color.white : Color("1B6AA3")
        } else {
            return Color("1B6AA3")
        }
    }
}

#Preview {
    DirectionTapDrillView()
}
