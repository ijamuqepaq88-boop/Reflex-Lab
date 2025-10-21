import SwiftUI

struct NavBar: View {
    init(_ title: String, showBackButton: Bool = false) {
        self.title = title
        self.showBackButton = showBackButton
    }
    
    let title: String
    let showBackButton: Bool
    
    @Environment(\.goBack) var goBack
    
    var body: some View {
        ZStack {
            if showBackButton {
                HStack(spacing: 0) {
                    Button {
                        goBack()
                    } label: {
                        Image(.arrowLeft)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 16, height: 16)
                            .frame(width: 40, height: 40)
                            .background {
                                Circle()
                                    .fill(Color.white.opacity(0.1))
                            }
                    }
                    .buttonStyle(.plain)
                    
                    Text(title)
                        .font(.poppins(.bold, size: 24))
                        .foregroundStyle(.white)
                        .multilineTextAlignment(.center)
                        .minimumScaleFactor(0.5)
                        .frame(maxWidth: .infinity)
                    
                    Color.clear
                        .frame(width: 40, height: 40)
                }
                .padding(.horizontal, 20)
            } else {
                Text(title)
                    .font(.poppins(.bold, size: 24))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 24)
            }
        }
        .frame(height: 60)
    }
}

#Preview {
    NavBar("Title", showBackButton: false)
        .background {
            Color.mainBg
        }
}
