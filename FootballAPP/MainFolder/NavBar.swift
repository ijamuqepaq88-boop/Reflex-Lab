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
                        if #available(iOS 15.0, *) {
                            Image(.arrowLeft)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 16, height: 16)
                                .frame(width: 40, height: 40)
                                .background {
                                    Circle()
                                        .fill(Color.white.opacity(0.1))
                                }
                        } else {
                            // Fallback on earlier versions
                        }
                    }
                    .buttonStyle(.plain)
                    
                    if #available(iOS 15.0, *) {
                        Text(title)
                            .font(.poppins(.bold, size: 24))
                            .foregroundStyle(.white)
                            .multilineTextAlignment(.center)
                            .minimumScaleFactor(0.5)
                            .frame(maxWidth: .infinity)
                    } else {
                        // Fallback on earlier versions
                    }
                    
                    Color.clear
                        .frame(width: 40, height: 40)
                }
                .padding(.horizontal, 20)
            } else {
                if #available(iOS 17.0, *) {
                    Text(title)
                        .font(.poppins(.bold, size: 24))
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 24)
                } else {
                    // Fallback on earlier versions
                }
            }
        }
        .frame(height: 60)
    }
}
