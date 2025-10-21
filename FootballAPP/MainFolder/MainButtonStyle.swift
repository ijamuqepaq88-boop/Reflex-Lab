import SwiftUI

struct MainButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.poppins(.semiBold, size: 16))
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 56)
            .background {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color("007BFF"))
                    .shadow(color: Color("007BFF"), radius: 6, y: 4)
            }
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
    }
}

extension ButtonStyle where Self == MainButtonStyle {
    static var main: Self { .init() }
}

#Preview {
    Button("Title", action: {})
        .buttonStyle(.main)
}
