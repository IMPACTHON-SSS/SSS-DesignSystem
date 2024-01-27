import SwiftUI

@available(iOS 15, macOS 12, *)
public extension Color {
    
    static func hexToColor(hex: String) -> UIColor {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        return UIColor(red: CGFloat(int >> 16) / 255,
                       green: CGFloat(int >> 8 & 0xFF) / 255,
                       blue: CGFloat(int & 0xFF) / 255,
                       alpha: 1)
    }
    
    init(light: String, dark: String? = nil) {
        let lightColor = Self.hexToColor(hex: light)
        if dark == nil {
            self = Self(lightColor)
        } else {
            let darkColor = Self.hexToColor(hex: dark!)
            self = Self(UIColor { $0.userInterfaceStyle == .dark ? darkColor : lightColor })
        }
    }
    
    static let main       = Color(light: "#FA7F3A")
    static let redColor   = Color(light: "#FE482F")
    static let kakao      = Color(light: "#FFE812")
    static let whiteColor = Color(light: "#FCFCFC")
    static let modifyGray = Color(light: "#F4F4F8")
    static let gray1      = Color(light: "#F1F1F1")
    static let gray2      = Color(light: "#E2E2E2")
    static let gray3      = Color(light: "#C7C7C7")
    static let gray4      = Color(light: "#B8B8B8")
    static let gray5      = Color(light: "#9D9D9D")
    static let gray6      = Color(light: "#7D7D7D")
    static let gray7      = Color(light: "#535353")
    static let gray8      = Color(light: "#353535")
    static let gray9      = Color(light: "#1E1E1E")
    static let blackColor = Color(light: "#191919")
}
