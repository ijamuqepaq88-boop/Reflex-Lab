import SwiftUI

struct MainTabView: View {
    @State private var selectedTab: Tab = .focus

    var body: some View {
        VStack(spacing: 0) {
            // Content Area
            Group {
                switch selectedTab {
                case .focus:
                    FocusDrillsView()
                case .drills:
                    BallDrillsView()
                case .vision:
                    FieldVisionView()
                case .stats:
                    StatsView()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            // Custom Tab Bar
            CustomTabBar(selectedTab: $selectedTab)
        }
        .ignoresSafeArea(.keyboard)
        .background {
            Color.mainBg.ignoresSafeArea()
        }
    }
}

struct CustomTabBar: View {
    @Binding var selectedTab: Tab
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(Tab.allCases) { tab in
                TabBarItem(
                    tab: tab,
                    selectedTab: $selectedTab
                )
            }
        }
        .background {
            Color("153453").ignoresSafeArea()
                .overlay(alignment: .top) {
                    Color("F9FEFE").opacity(0.1)
                        .frame(height: 1)
                }
        }
    }
}

struct TabBarItem: View {
    let tab: Tab
    @Binding var selectedTab: Tab
    
    private var isSelected: Bool {
        selectedTab == tab
    }
    
    var body: some View {
        Button {
            selectedTab = tab
        } label: {
            VStack(spacing: 5) {
                Image(tab.icon)
                    .resizable()
                    .renderingMode(.template)
                    .scaledToFit()
                    .frame(maxWidth: 26)
                
                Text(tab.rawValue)
                    .font(.montserrat(.regular, size: 12))
            }
            .foreground(isSelected ? "FFFFFF" : "8DB9E3")
            .frame(maxWidth: .infinity)
            .padding(.top, 16)
            .padding(.bottom, 8)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    MainTabView()
        .preferredColorScheme(.dark)
}
