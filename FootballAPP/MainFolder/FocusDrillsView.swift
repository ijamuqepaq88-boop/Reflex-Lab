import SwiftUI

struct FocusDrillsView: View {
    @State private var selectedDrillIndex = 0
    @State private var dragOffset: CGFloat = 0
    
    private var currentDrill: FocusDrill {
        return FocusDrill.allCases[selectedDrillIndex]
    }
    
    var body: some View {
        VStack(spacing: 0) {
           NavBar("Focus Drills")
                .padding(.bottom, 20)
            
            VStack(alignment: .leading, spacing: 10) {
                Text(currentDrill.name)
                    .font(.poppins(.bold, size: 30))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text((currentDrill.name).description)
                    .font(.poppins(.regular, size: 14))
            }
            .foregroundStyle(.white)
            .padding(.horizontal, 24)
            .padding(.bottom, 20)
            
            GeometryReader { geometry in
                ZStack {
                    ForEach(Array(FocusDrill.allCases.enumerated()), id: \.element.id) { index, drill in
                        Image(drill.imageName)
                            .resizable()
                            .scaledToFit()
                            .scaleEffect(index == selectedDrillIndex ? 1.0 : 0.8)
                            .opacity(index == selectedDrillIndex ? 1.0 : 0.3)
                            .offset(x: CGFloat(index - selectedDrillIndex) * geometry.size.width * 0.7 + dragOffset)
                            .animation(.spring(response: 0.6, dampingFraction: 0.8), value: selectedDrillIndex)
                            .animation(.spring(response: 0.3, dampingFraction: 0.8), value: dragOffset)
                    }
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            dragOffset = value.translation.width
                        }
                        .onEnded { value in
                            let threshold: CGFloat = 50
                            if value.translation.width > threshold && selectedDrillIndex > 0 {
                                selectedDrillIndex -= 1
                            } else if value.translation.width < -threshold && selectedDrillIndex < FocusDrill.allCases.count - 1 {
                                selectedDrillIndex += 1
                            }
                            dragOffset = 0
                        }
                )
            }
            .frame(maxHeight: 400)
            .padding(.bottom, 40)
            
            NavigationLink("Play") {
                switch currentDrill {
                case .directionTap:
                    DirectionTapDrillView()
                case .colorMatch:
                    ColorMatchDrillView()
                case .timedTap:
                    TimedTapDrillView()
                case .timerStop:
                    TimerStopDrillView()
                }
            }
            .buttonStyle(.main)
            .padding(.horizontal, 24)
            .padding(.bottom, 30)
        }
        .background {
            Color.mainBg.ignoresSafeArea()
        }
    }
}


#Preview {
    FocusDrillsView()
}
