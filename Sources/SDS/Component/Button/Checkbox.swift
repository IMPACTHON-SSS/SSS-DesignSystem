import SwiftUI

@available(iOS 16, macOS 13, *)
public struct Checkbox: View {
    
    @Binding var isChecked: Bool
    
    public init(isChecked: Binding<Bool>) {
        self._isChecked = isChecked
    }
    
    public var body: some View {
        Button {
            isChecked.toggle()
        } label: {
            ZStack {
                let rectangle = RoundedRectangle(cornerRadius: 4)
                rectangle
                    .strokeBorder(Color.gray4, lineWidth: 1)
                if isChecked {
                    rectangle
                        .fill(Color.main)
                    Image.check
                        .foregroundStyle(Color.whiteColor)
                        .scaledToFit()
                        .frame(width: 15.5)
                }
            }
            .frame(width: 24, height: 24)
        }
    }
}

struct CheckboxPreview: View {
    
    @State var isChecked: Bool = false
    
    var body: some View {
        Checkbox(isChecked: $isChecked)
    }
}

@available(iOS 16, macOS 13, *)
#Preview {
    return CheckboxPreview()
}
