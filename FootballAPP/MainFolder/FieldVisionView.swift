import SwiftUI

struct FieldVisionView: View {
    @StateObject private var viewModel = VisionViewModel()
    
    // Define custom colors based on the image
    private let panelBackgroundColor = Color.black.opacity(0.3)
    private let zoneCircleColor = Color(red: 0/255, green: 122/255, blue: 255/255) // Blue for circles

    var body: some View {
            VStack(spacing: 10) {
                NavBar("Field Vision")

                ZStack(alignment: viewModel.selectedZone?.displayId == 5 ? .top : .bottom) {
                    GeometryReader { geometry in
                        ZStack {
                            Image(.field)
                                .resizable()
                                .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 2)
                                .onTapGesture {
                                    viewModel.deselectZone()
                                }

                            ForEach(viewModel.fieldZones) { zone in
                                ZoneIndicatorView(
                                    zone: zone,
                                    isSelected: viewModel.selectedZone?.id == zone.id,
                                    size: geometry.size,
                                    circleColor: zoneCircleColor
                                ) {
                                    viewModel.selectZone(zone)
                                }
                            }
                        }
                        .frame(width: geometry.size.width, height: geometry.size.height)
                    }
                    .aspectRatio(343/517, contentMode: .fit)
                    .padding(.horizontal, viewModel.selectedZone == nil ? 20 : 24)
                    
                    if let selectedZone = viewModel.selectedZone {
                        zoneInfoPanel(for: selectedZone)
                            .padding(.horizontal, 16)
                            .zIndex(1)
                    }
                }
                .frame(maxHeight: .infinity)
            }
            .animation(.default, value: viewModel.selectedZone)
    }
    
    @ViewBuilder
    private func zoneInfoPanel(for zone: FieldZone) -> some View {
        VStack(spacing: 16) {
            HStack(alignment: .top, spacing: 12) {
                ZStack {
                    Circle()
                        .fill(Color("007BFF"))
                        .frame(width: 50, height: 50)
                    Text(String(zone.displayId))
                        .font(.poppins(.bold, size: 24))
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(zone.name)
                        .font(.poppins(.semiBold, size: 16))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    ForEach(zone.typicalActions, id: \.self) { action in
                        Text("• \(action)")
                            .font(.poppins(.regular, size: 14))
                    }
                }
            }
            
            Button("Close") {
                viewModel.selectedZone = nil
            }
            .buttonStyle(.main)
            .padding(.horizontal, 10)
        }
        .foregroundStyle(.white)
        .padding(16)
        .padding(.vertical, 10)
        .background {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color("235F97"))
                RoundedRectangle(cornerRadius: 12)
                    .strokeBorder(Color("4F7FAC"), lineWidth: 1)
            }
        }
        .transition(.opacity.combined(with: .scale))
        .animation(.default, value: viewModel.selectedZone)
    }
}

private struct ZoneIndicatorView: View {
    let zone: FieldZone
    let isSelected: Bool
    let size: CGSize
    let circleColor: Color
    let action: () -> Void

    private let circleDiameter: CGFloat = 45

    var body: some View {
        Button(action: action) {
            ZStack {
                Circle()
                    .fill(Color("4991DA"))
                    .shadow(color: Color("06223F").opacity(0.3), radius: 10)
                    .shadow(color: isSelected ? .white.opacity(0.7) : .clear, radius: isSelected ? 3 : 0)
                Text(String(zone.displayId))
                    .font(.montserrat(.extraBold, size: 14))
                    .foregroundStyle(.white)
                Circle()
                    .strokeBorder(Color.white, lineWidth: 1.5)
            }
            .frame(width: circleDiameter, height: circleDiameter)
            .scaleEffect(isSelected ? 1.1 : 1.0)
            .animation(.spring(), value: isSelected)
        }
        .position(
            x: zone.position.x * size.width,
            y: zone.position.y * size.height
        )
        .buttonStyle(.plain)
    }
}


// Sample Data
extension FieldZone {
    static let sampleZones: [FieldZone] = [
        FieldZone(name: "Penalty Area (Attacking)",
                  typicalActions: ["Shooting", "Goalie Saves", "Headers", "Penalties"],
                  position: CGPoint(x: 0.5, y: 0.1),
                  displayId: 1), // Relative coordinates
        FieldZone(name: "Central Midfield",
                  typicalActions: ["Passing", "Tackling", "Dribbling", "Ball Retention"],
                  position: CGPoint(x: 0.5, y: 0.3),
                  displayId: 4),
        // Add more zones (9-12 total)
        FieldZone(name: "Left Wing",
                  typicalActions: ["Crossing", "Dribbling", "Supporting Attacks"],
                  position: CGPoint(x: 0.2, y: 0.3),
                  displayId: 2),
        FieldZone(name: "Right Wing",
                  typicalActions: ["Crossing", "Dribbling", "Overlapping Runs"],
                  position: CGPoint(x: 0.8, y: 0.3),
                  displayId: 3),
        FieldZone(name: "Defensive Midfield",
                  typicalActions: ["Interceptions", "Screening Defense", "Distribution"],
                  position: CGPoint(x: 0.5, y: 0.7),
                  displayId: 5)
    ]
}


#Preview {
    FieldVisionView()
        .background(Color.mainBg)
}
