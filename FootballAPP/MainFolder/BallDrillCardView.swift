import SwiftUI

struct BallDrillCardView: View {
    let drill: BallDrill

    var body: some View {
        if #available(iOS 15.0, *) {
            HStack(spacing: 16) {
                Image(drill.imageName)
                    .resizable()
                    .scaleAspectFill()
                    .frame(width: 140, height: 140)
                
                VStack(alignment: .leading, spacing: 12) {
                    Text(drill.title)
                        .font(.poppins(.bold, size: 16))
                        .foreground("1F2937")
                    
                    Text(drill.subtitle)
                        .font(.poppins(.regular, size: 14))
                        .foreground("4B5563")
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                }
                .multilineTextAlignment(.leading)
                .padding(.vertical, 14)
                .padding(.trailing, 14)
            }
            .frame(height: 140)
            .background {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color("BCDCFF"))
            }
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .overlay {
                RoundedRectangle(cornerRadius: 12)
                    .strokeBorder(Color("E5E7EB"), lineWidth: 1)
            }
        } else {
            // Fallback on earlier versions
        }
    }
}

#Preview {
    BallDrillCardView(drill: BallDrill.all[2])
        .padding()
}
