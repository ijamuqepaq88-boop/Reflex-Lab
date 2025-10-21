import SwiftUI

struct DrillCompleteView: View {
    let score: Int
    let onTryAgain: () -> Void
    
    @State private var showResult = false
    @Environment(\.goBack) var goBack
    
    var body: some View {
        ZStack {
            Color("040404")
                .opacity(0.7)
                .ignoresSafeArea()
            
            if showResult {
                VStack(spacing: 60) {
                    VStack(spacing: 20) {
                        Text("Drill Complete!")
                            .font(.poppins(.bold, size: 41))
                            .foreground("FFD700")
                            .multilineTextAlignment(.center)
                        
                        Text("Final Score: \(score)")
                            .font(.poppins(.medium, size: 18))
                        .foregroundStyle(.white)
                    }
                    
                    VStack(spacing: 16) {
                        Button("Try Again") {
                            onTryAgain()
                        }
                        .buttonStyle(.main)
                        
                        Button {
                            goBack()
                        } label: {
                            Text("Choose Another Dril")
                                .font(.poppins(.semiBold, size: 16))
                                .foregroundStyle(.white)
                                .frame(height: 24)
                        }
                    }
                    .padding(.horizontal, 20)
                }
                .padding(.top, 100)
                .padding(.horizontal, 20)
                .padding(.bottom, 30)
                .background {
                    ZStack {
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color("00396E"))
                        RoundedRectangle(cornerRadius: 15)
                            .strokeBorder(Color("FFD700"), lineWidth: 2)
                    }
                }
                .padding(.horizontal, 24)
                .frame(maxHeight: .infinity)
                .zIndex(1)
                .transition(.move(edge: .bottom))
            }
        }
        .onAppear {
            DispatchQueue.main.async {
                withAnimation(.easeInOut(duration: 0.6).delay(0.2)) {
                    showResult = true
                }
            }
        }
    }
}

#Preview {
    DrillCompleteView(score: 123, onTryAgain: {})
}
