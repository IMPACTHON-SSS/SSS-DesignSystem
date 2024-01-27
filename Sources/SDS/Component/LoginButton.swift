import SwiftUI

@available(iOS 15, macOS 12, *)
public struct LoginButton: View {
    
    let action: () -> Void
    
    public init(action: @escaping () -> Void) {
        self.action = action
    }
    
    public var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                Image.apple
                    .scaledToFit()
                    .frame(height: 17.25)
                Text("Apple 계정으로 계속하기")
                    .font(.system(size: 16, weight: .semibold))
            }
            .foregroundStyle(Color.whiteColor)
            .frame(height: 24)
            .padding(11)
            .frame(maxWidth: .infinity)
            .background(Color.blackColor)
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
    }
}

struct LoginButtonPreview: View {
    
    var body: some View {
        LoginButton {
            print("Pressed")
        }
        .padding()
    }
}

@available(iOS 15, macOS 12, *)
#Preview {
    return LoginButtonPreview()
}
