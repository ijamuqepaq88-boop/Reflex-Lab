import SwiftUI

struct BallDrillDetailView: View {
    @StateObject var viewModel = BallDrillsViewModel()
    let drill: BallDrill

    var body: some View {
        VStack(spacing: 16) {
            NavBar(drill.title, showBackButton: true)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    // Placeholder for large static image or schema
                    Image(drill.imageName)
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    
                    Text(drill.title)
                        .font(.poppins(.bold, size: 16))
                        .foreground("1F2937")
                        .padding(.horizontal, 10)
                    
                    Text(drill.text)
                        .font(.poppins(.regular, size: 14))
                        .foreground("4B5563")
                        .padding(.horizontal, 10)
                        .padding(.bottom, 10)
                    
                    timerSection
                        .padding(.horizontal, 6)
                        .padding(.bottom, 6)
                }
                .background {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color("D2E8FF"))
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 30)
            }
        }
        .background {
            Color("0A4D8C").ignoresSafeArea()
        }
        .hideSystemNavBar()
        .onAppear {
            viewModel.drillViewed(drill)
            viewModel.resetTimer() // Reset timer when view appears
        }
        .onDisappear {
            viewModel.addTimerUsage(viewModel.timerValue) // Add used time to stats
        }
    }
    
    private var timerSection: some View {
        HStack(spacing: 10) {
            Text(String(format: "%02d:%02d:%02d", viewModel.timerValue / 3600, (viewModel.timerValue % 3600) / 60, viewModel.timerValue % 60))
                .font(.poppins(.bold, size: 24))
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Button(action: viewModel.pauseTimer) {
                Image(.buttonPause)
                    .resizable()
                    .frame(width: 43, height: 43)
            }
            .opacity(viewModel.isTimerRunning ? 1.0 : 0.6)
            
            Button(action: viewModel.startTimer) {
                Image(.buttonPlay)
                    .resizable()
                    .frame(width: 57, height: 57)
            }
            .opacity(viewModel.isTimerRunning ? 0.6 : 1.0)
            
            Button(action: viewModel.resetTimer) {
                Image(.buttonRestart)
                    .resizable()
                    .frame(width: 43, height: 43)
            }
        }
        .frame(height: 80)
        .padding(.horizontal, 14)
        .background {
            RoundedRectangle(cornerRadius: 14)
                .fill(Color("007BFF"))
        }
    }
}

#Preview {
    BallDrillDetailView(drill: BallDrill.all[0])
}
