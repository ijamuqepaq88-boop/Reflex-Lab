import SwiftUI

struct OnboardingPage {
    let imageName: String
    let title: String
    let description: String
}

struct OnboardingView: View {
    @AppStorage(SaveKey.showOnboarding) var showOnboarding = true
    @State private var currentPage = 0
    @State private var imageOpacity = 0.0
    @State private var titleOpacity = 0.0
    @State private var descriptionOpacity = 0.0

    let pages: [OnboardingPage] = [
        OnboardingPage(imageName: "onb0", title: "Boost Your Reaction Time", description: "Enhance your cognitive abilities and reaction speed with our specialized training drills."),
        OnboardingPage(imageName: "onb1", title: "Sharpen Your Mind", description: "Engage in exercises designed to improve focus, attention, and decision-making skills."),
        OnboardingPage(imageName: "onb2", title: "Track Your Progress", description: "Monitor your performance, see your improvements, and stay motivated on your journey to peak mental agility.")
    ]
   
    var body: some View {
        ZStack {
            Color.mainBg.ignoresSafeArea()

            VStack(spacing: 0) {
                Image(pages[currentPage].imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 248)
                    .frame(maxHeight: .infinity)
                    .opacity(imageOpacity)

                if #available(iOS 15.0, *) {
                    VStack(spacing: 20) {
                        Text(pages[currentPage].title)
                            .font(.poppins(.bold, size: 24))
                            .multilineTextAlignment(.center)
                            .opacity(titleOpacity)
                        
                        Text(pages[currentPage].description)
                            .font(.poppins(.regular, size: 16))
                            .opacity(0.9 * descriptionOpacity)
                            .multilineTextAlignment(.center)
                    }
                    .foregroundStyle(.white)
                    .padding(.horizontal, 24)
                    .padding(.bottom, 35)
                } else {
                    // Fallback on earlier versions
                }
                
                HStack(spacing: 8) {
                    ForEach(0..<pages.count, id: \.self) { index in
                        RoundedRectangle(cornerRadius: 3)
                            .fill(Color.white)
                            .frame(width: 40, height: 6)
                            .opacity(index == currentPage ? 1 : 0.3)
                    }
                }
                .padding(.bottom, 50)

                Button {
                    if currentPage < pages.count - 1 {
                        resetAnimations()
                        currentPage += 1
                        startAnimations()
                    } else {
                        showOnboarding = false
                    }
                } label: {
                    if currentPage < pages.count - 1 {
                        HStack(spacing: 8) {
                            Text("Next")
                            
                            Image(.arrowRight)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 16, height: 16)
                        }
                    } else {
                        Text("Start")
                    }
                }
                .buttonStyle(.main)
                .padding(.horizontal, 24)
                .padding(.bottom, 20)
                .animation(.default, value: currentPage)
                
                Button {
                    showOnboarding = false
                } label: {
                    if #available(iOS 15.0, *) {
                        Text("Skip")
                            .font(.poppins(.medium, size: 14))
                            .foregroundStyle(.white)
                            .frame(height: 20)
                            .opacity(0.7)
                    } else {
                        // Fallback on earlier versions
                    }
                }
                .opacity(currentPage == 2 ? 0 : 1)
                .padding(.bottom, 40)
                .animation(.default, value: currentPage)
            }
        }
        .preferredColorScheme(.dark)
        .onAppear {
            startAnimations()
        }
    }
    
    private func startAnimations() {
        withAnimation(.easeInOut(duration: 0.6).delay(0.1)) {
            imageOpacity = 1.0
        }
        
        withAnimation(.easeInOut(duration: 0.6).delay(0.4)) {
            titleOpacity = 1.0
        }
        
        withAnimation(.easeInOut(duration: 0.6).delay(0.7)) {
            descriptionOpacity = 1.0
        }
    }
    
    private func resetAnimations() {
        imageOpacity = 0.0
        titleOpacity = 0.0
        descriptionOpacity = 0.0
    }
}

#Preview {
    OnboardingView()
}
