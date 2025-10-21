import SwiftUI

struct BallDrillsView: View {
    var body: some View {
        VStack(spacing: 20) {
            NavBar("Ball Drills")
            
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(BallDrill.all) { drill in
                        NavigationLink {
                            BallDrillDetailView(drill: drill)
                        } label: {
                            BallDrillCardView(drill: drill)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 30)
            }
        }
    }
}

#Preview {
    BallDrillsView()
        .background(Color.mainBg)
}
