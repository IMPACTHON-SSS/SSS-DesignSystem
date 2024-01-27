import SwiftUI

@available(iOS 15, macOS 12, *)
public struct LoginButton: View {
    
    let type: ButtonType
    let action: () -> Void
    
    public init(_ type: ButtonType, action: @escaping () -> Void) {
        self.type = type
        self.action = action
    }
    
    public enum ButtonType: String {
        case apple = "Apple 계정으로 계속하기"
        case kakao = "카카오 로그인"
        
        var icon: some View {
            switch self {
            case .apple:
                Image.appleLogo
                    .scaledToFit()
                    .frame(height: 17.25)
            case .kakao:
                Image.kakaoLogo
                    .scaledToFit()
                    .frame(width: 23.52)
            }
        }
        
        var foregroundColor: Color {
            switch self {
            case .apple: .whiteColor
            case .kakao: .blackColor
            }
        }
        
        var backgroundColor: Color {
            switch self {
            case .apple: .blackColor
            case .kakao: .kakao
            }
        }
    }
    
    public var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                type.icon
                Text(type.rawValue)
                    .font(.system(size: 16, weight: .semibold))
            }
            .foregroundStyle(type.foregroundColor)
            .frame(height: 24)
            .padding(.vertical, 11)
            .frame(maxWidth: .infinity)
            .background(type.backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
    }
}

struct LoginButtonPreview: View {

    var body: some View {
        VStack {
            LoginButton(.kakao) {
                print("Pressed")
            }
            LoginButton(.apple) {
                print("Pressed")
            }
        }
        .padding()
    }
}

@available(iOS 15, macOS 12, *)
#Preview {
    return LoginButtonPreview()
}
