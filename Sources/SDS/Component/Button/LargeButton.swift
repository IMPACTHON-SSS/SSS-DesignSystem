import SwiftUI
import Combine

@available(iOS 16, macOS 13, *)
public struct LargeButton: View {
    
    let title: String
    let isDisabled: Bool
    let action: () -> Void
    
    @State var isKeyboardUp: Bool = false
    
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
    
    var keyboardState: AnyPublisher<Bool, Never> {
      Publishers.Merge(
        NotificationCenter.default
          .publisher(for: UIResponder.keyboardWillShowNotification)
          .map { _ in true },
        NotificationCenter.default
          .publisher(for: UIResponder.keyboardWillHideNotification)
          .map { _ in false }
      )
      .eraseToAnyPublisher()
    }
    
    public var body: some View {
        Button(action: action) {
            Text(title)
                .foregroundStyle(isDisabled ? Color.gray4 : .blackColor)
                .font(.system(size: 16, weight: .semibold))
                .padding(16)
                .frame(maxWidth: .infinity)
                .background(isDisabled ? Color.gray1 : .main)
                .clipShape(RoundedRectangle(cornerRadius: isKeyboardUp ? 0 : 12))
        }
        .padding([.horizontal, .bottom], isKeyboardUp ? 0 : 24)
        .disabled(isDisabled)
        .onReceive(keyboardState) { newValue in
            withAnimation(.linear(duration: 0.15)) {
                isKeyboardUp = newValue
            }
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

@available(iOS 16, macOS 13, *)
#Preview {
    return LargeButtonPreview()
}
