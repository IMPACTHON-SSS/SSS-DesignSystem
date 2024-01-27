import SwiftUI

@available(iOS 15, macOS 12, *)
public struct AgreementButton: View {
    
    let title: String
    @Binding var isChecked: Bool
    let isRequired: Bool
    let action: () -> Void
    
    public init(_ title: String,
                isChecked: Binding<Bool>,
                isRequired: Bool = false,
                action: @escaping () -> Void) {
        self.title = title
        self._isChecked = isChecked
        self.isRequired = isRequired
        self.action = action
    }
    
    public func required(_ condition: Bool = true) -> Self {
        .init(title,
              isChecked: $isChecked,
              isRequired: condition,
              action: action)
    }
    
    public var body: some View {
        HStack(spacing: 12) {
            Checkbox(isChecked: $isChecked)
            Button(action: action) {
                Text("[\(isRequired ? "필수" : "선택")] ")
                    .foregroundColor(isRequired ? .redColor : .gray7)
                +
                Text(title)
                    .foregroundColor(.gray7)
                Spacer()
                Image.smallArrow
                    .foregroundStyle(Color.gray7)
                    .scaledToFit()
                    .frame(height: 11.15)
                    .rotationEffect(.degrees(180))
            }
        }
        .font(.system(size: 16, weight: .medium))
    }
}

struct AgreementButtonPreview: View {
    
    @State var isChecked: Bool = false
    
    var body: some View {
        AgreementButton("테스트", isChecked: $isChecked) {
            print("Hello")
        }
        .required()
    }
}

@available(iOS 15, macOS 12, *)
#Preview {
    return AgreementButtonPreview()
}
