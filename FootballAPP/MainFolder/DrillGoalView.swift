import SwiftUI

struct DrillGoalView<Content: View>: View {
    let title: String
    @ViewBuilder let content: () -> Content
    
    var body: some View {
        HStack(spacing: 12) {
            content()
                .frame(width: 48, height: 48)
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Goal")
                    .font(.poppins(.semiBold, size: 16))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text(title)
                    .font(.poppins(.regular, size: 14))
            }
        }
        .foregroundStyle(.white)
        .padding(16)
        .background {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.white.opacity(0.1))
                RoundedRectangle(cornerRadius: 12)
                    .strokeBorder(Color.white.opacity(0.2), lineWidth: 1)
            }
        }
    }
}

#Preview {
    DrillGoalView(title: "Title") {
       Circle()
    }
    .padding()
    .background(Color.mainBg)
}
