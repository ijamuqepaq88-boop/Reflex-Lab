import SwiftUI

@available(iOS 15.0, *)
struct TimerStopDrillView: View {
    @StateObject private var viewModel = TimerStopViewModel()

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

    @available(iOS 15.0, *)
    private var contentView: some View {
        VStack(spacing: 15) {
            NavBar("Timer Stop", showBackButton: true)

            DrillGoalView(title: "Tap on time") {
                ZStack {
                    Circle()
                        .fill(Color("007BFF").opacity(0.8))
                    
                    Text(String(format: "%.0f", viewModel.targetTime))
                        .font(.poppins(.bold, size: 24))
                        .foregroundColor(.white)
                }
            }
            .padding(.horizontal, 24)

            VStack(spacing: 20) {
                Text(viewModel.feedbackMessage.isEmpty ? " " : viewModel.feedbackMessage)
                    .font(.poppins(.bold, size: 24))
                    .foregroundColor(Color("FFD700"))
                    .multilineTextAlignment(.center)
                    .frame(height: 60)


                Text(String(format: "%.2f", viewModel.timerValue))
                    .font(.poppins(.bold, size: 60))
                    .foregroundColor(.white)
                
                CustomProgressView(value: viewModel.timerValue, maxValue: viewModel.targetTime)
                    .frame(height: 10)
                    .padding(.horizontal, 40)


                Button {
                    if viewModel.isRunning {
                        viewModel.stopTimer()
                    } else {
                        viewModel.startTimer()
                    }
                } label: {
                    Text(viewModel.isRunning ? "Stop" : "Start")
                        .font(.poppins(.semiBold, size: 20))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(Color("007BFF"))
                        .cornerRadius(12)
                }
                .padding(.horizontal, 40)
                .padding(.top, 20)
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
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 4).fill(Color("071F36"))
                    RoundedRectangle(cornerRadius: 4).fill(Color("FFD700"))
                        .frame(width: max(0, geo.size.width * viewModel.progress)) // Ensure width is not negative
                }
            }
            .frame(height: 8)
            .animation(.default, value: viewModel.progress) // Animate progress changes
                .padding(.horizontal, 24)
                .padding(.bottom, 30)

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            Color.mainBg.ignoresSafeArea()
        }
    }
}

struct CustomProgressView: View {
    var value: Double
    var maxValue: Double
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .opacity(0.3)
                    .foregroundColor(Color("007BFF"))
                
                Rectangle()
                    .frame(width: min(CGFloat(self.value / self.maxValue) * geometry.size.width, geometry.size.width), height: geometry.size.height)
                    .foregroundColor(Color("007BFF"))
                    .animation(.linear, value: value)
            }
            .cornerRadius(45.0)
        }
    }
}
