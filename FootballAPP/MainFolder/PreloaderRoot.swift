import SwiftUI

struct PreloaderRoot: View {
    @State private var animateCircles = false
    
    var body: some View {
        ZStack {
            Color.mainBg
                .ignoresSafeArea()
            
            // Multiple pulsating circles
            ForEach(0..<8, id: \.self) { index in
                let circleSize = CGFloat(50 + index * 20)
                let scaleValue = animateCircles ? 1.2 + CGFloat(index) * 0.1 : 0.3
                let opacityValue = animateCircles ? 0.3 - Double(index) * 0.02 : 0.8
                let animationDuration = 1.5 + Double(index) * 0.2
                let animationDelay = Double(index) * 0.15
                
                Circle()
                    .strokeBorder(Color.white.opacity(0.3), lineWidth: 2)
                    .background(Circle().fill(Color.white.opacity(0.05)))
                    .frame(width: circleSize, height: circleSize)
                    .scaleEffect(scaleValue)
                    .opacity(opacityValue)
                    .animation(
                        Animation.easeInOut(duration: animationDuration)
                            .repeatForever(autoreverses: true)
                            .delay(animationDelay),
                        value: animateCircles
                    )
            }
            
            // Center core circle
            Circle()
                .fill(Color.white.opacity(0.8))
                .frame(width: 8, height: 8)
                .scaleEffect(animateCircles ? 2.0 : 0.5)
                .animation(
                    Animation.easeInOut(duration: 1.0)
                        .repeatForever(autoreverses: true),
                    value: animateCircles
                )
        }
        .onAppear {
            animateCircles = true
        }
    }
}

#Preview {
    PreloaderRoot()
}
