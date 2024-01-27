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
            Text("[\(isRequired ? "필수" : "선택")]")
            Text(title)
        }
        .font(.system(size: 16, weight: .medium))
    }
}

//struct AgreementButtonPreview: View {
//    
//    @State var isChecked: Bool = false
//    
//    var body: some View {
//        Checkbox(isChecked: $isChecked)
//    }
//}
//
//@available(iOS 15, macOS 12, *)
//#Preview {
//    return AgreementButton()
//}
