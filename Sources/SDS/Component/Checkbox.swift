import SwiftUI

@available(iOS 15, macOS 12, *)
public struct Checkbox: View {
    
    @Binding var isChecked: Bool
    
    public init(isChecked: Binding<Bool>) {
        self._isChecked = isChecked
    }
    
    public var body: some View {
        Button {
            isChecked.toggle()
        } label: {
            RoundedRectangle(cornerRadius: 4)
                .frame(width: 24, height: 24)
        }
    }
}

@available(iOS 15, macOS 12, *)
#Preview {
    @State var isChecked: Bool = false
    return Checkbox(isChecked: $isChecked)
}
