import SwiftUI

@available(iOS 15, macOS 12, *)
public struct LargeButton: View {
    
    let title: String
    let isDisabled: Bool
    let action: () -> Void
    
    public init(_ title: String,
                isDisabled: Bool = false,
                action: @escaping () -> Void) {
        self.title = title
        self.isDisabled = isDisabled
        self.action = action
    }
    
    public func disabled(_ condition: Bool = true) -> Self {
        .init(title, isDisabled: condition, action: action)
    }
    
    public var body: some View {
        Button(action: action) {
            Text(title)
                .foregroundStyle(isDisabled ? Color.gray4 : .blackColor)
                .font(.system(size: 16, weight: .semibold))
                .padding(16)
                .frame(maxWidth: .infinity)
                .background(isDisabled ? Color.gray1 : .main)
                .clipShape(RoundedRectangle(cornerRadius: 12))
        }
        .disabled(isDisabled)
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
