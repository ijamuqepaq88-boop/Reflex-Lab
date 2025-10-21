import SwiftUI

struct AppRoot: View {
    @AppStorage(SaveKey.showOnboarding) var showOnboarding = true
    @State private var showPreloader = true
    
    var body: some View {
        ZStack {
            NavigationStack {
                MainTabView()
            }
            
            if showOnboarding {
                OnboardingView()
                    .zIndex(1)
            }
            
            if showPreloader {
                PreloaderRoot()
                    .zIndex(2)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                            showPreloader = false
                        }
                    }
            }
        }
        .dynamicTypeSize(.large)
        .animation(.default, value: showPreloader)
        .animation(.default, value: showOnboarding)
        
    }
}
