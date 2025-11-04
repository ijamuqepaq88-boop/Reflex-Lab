import SwiftUI

extension Color {
    init(_ hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8 * 17) & 0xF0, (int >> 4 * 17) & 0xF0, int * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, (int >> 16) & 0xFF, (int >> 8) & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = ((int >> 24) & 0xFF, (int >> 16) & 0xFF, (int >> 8) & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

extension View {
    @available(iOS 15.0, *)
    func foreground(_ hex: String) -> some View {
        foregroundStyle(Color(hex))
    }
}

import SwiftUI

extension Image {
    @available(iOS 15.0, *)
    func scaleAspectFill(_ alignment: Alignment = .center) -> some View {
        Color.clear
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(alignment: alignment) {
                self
                    .resizable()
                    .scaledToFill()
            }
            .clipped()
    }
}

import SwiftUI

extension View {
    func hideSystemNavBar() -> some View {
        self
            .navigationBarTitle("")
            .navigationBarHidden(true)
    }
}

extension EnvironmentValues {
    var goBack: () -> Void {
        if #available(iOS 17.0, *) {
            { dismiss() }
        } else {
            { presentationMode.wrappedValue.dismiss() }
        }
    }
}

import SwiftUI

protocol Fontable {
    var rawValue: String { get }
}

extension Fontable {
    var name: String {
        return String(describing: Self.self) + "-" + rawValue.capitalized
    }
}

extension Font {
    enum Montserrat: String, Fontable {
        case extraBold
        case medium
        case regular
    }
    
    static func montserrat(_ family: Montserrat, size: CGFloat) -> Font {
        return .custom(family.name, fixedSize: size)
    }
}

extension Font {
    enum Poppins: String, Fontable {
        case bold
        case medium
        case regular
        case semiBold
    }
    
    static func poppins(_ family: Poppins, size: CGFloat) -> Font {
        return .custom(family.name, fixedSize: size)
    }
}

import Foundation

extension Notification.Name {
    static let closePreloader = Notification.Name("closePreloader")
    static let onboardingDidFinish = Notification.Name("onboardingDidFinish")
}

import SwiftUI

final class OrientationInfo {
    static func updateOrientation(_ orientationLock: UIInterfaceOrientationMask) {
        if #available(iOS 16.0, *) {
            UIApplication.shared.connectedScenes.forEach { scene in
                if let windowScene = scene as? UIWindowScene {
                    windowScene.requestGeometryUpdate(.iOS(interfaceOrientations: orientationLock))
                    windowScene.windows.first?.rootViewController?.setNeedsUpdateOfSupportedInterfaceOrientations()
                }
            }
        } else {
            UIApplication.shared.connectedScenes.forEach { scene in
                if scene is UIWindowScene {
                    if orientationLock == .landscape {
                        UIDevice.current.setValue(UIInterfaceOrientation.landscapeRight.rawValue, forKey: "orientation")
                    } else {
                        UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
                    }
                }
            }
        }
    }
}

