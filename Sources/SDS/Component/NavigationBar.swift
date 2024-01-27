import SwiftUI

@available(iOS 15, macOS 12, *)
public struct NavigationBar<C: View>: View {
    
    @Environment(\.dismiss) var dismiss
    
    let content: () -> C
    
    public init(@ViewBuilder content: @escaping () -> C) {
        self.content = content
    }
    
    public var body: some View {
        VStack(alignment: .leading) {
            Button {
                dismiss()
            } label: {
                Image.bigArrow
                    .foregroundStyle(Color.blackColor)
                    .scaledToFit()
                    .frame(width: 24, height: 24)
            }
            .padding(.vertical, 14)
            .padding(.horizontal, 16)
            content()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

struct NavigationBarPreview: View {
    
    var body: some View {
        NavigationBar {
            Text("Hello")
        }
    }
}

@available(iOS 15, macOS 12, *)
#Preview {
    return NavigationBarPreview()
}
