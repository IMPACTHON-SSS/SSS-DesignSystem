import SwiftUI

@available(iOS 15, macOS 12, *)
public struct LargeButton: View {
    
    let title: String
    let action: () -> Void
    
    public init(_ title: String, action: @escaping () -> Void) {
        self.title = title
        self.action = action
    }
    
    public var body: some View {
        Button(action: action) {
            Text(title)
                .foregroundStyle(Color.whiteColor)
                .font(.system(size: 16, weight: .semibold))
                .padding(16)
                .frame(maxWidth: .infinity)
                .background(Color.main)
                .clipShape(RoundedRectangle(cornerRadius: 12))
        }
    }
}

struct LargeButtonPreview: View {
    
    var body: some View {
        LargeButton("다음") {
            print("Pressed")
        }
    }
}

@available(iOS 15, macOS 12, *)
#Preview {
    return LargeButtonPreview()
}
