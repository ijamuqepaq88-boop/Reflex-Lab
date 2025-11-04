import SwiftUI

struct AppRoot: View {
    @AppStorage(SaveKey.showOnboarding) var showOnboarding = true
    @State private var showPreloader = true
    
    var body: some View {
        if #available(iOS 15.0, *) {
            ZStack {
                if #available(iOS 16.0, *) {
                    NavigationStack {
                        MainTabView()
                    }
                } else {
                    // Fallback on earlier versions
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
        } else {
            // Fallback on earlier versions
        }
        
    }
}
