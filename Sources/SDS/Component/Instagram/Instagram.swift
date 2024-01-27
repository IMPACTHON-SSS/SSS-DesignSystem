import SwiftUI

@available(iOS 16, macOS 13, *)
public struct Instagram<C: View> {
    
    let id: Int
    let content: () -> C
    
    public init(id: Int, @ViewBuilder content: @escaping () -> C) {
        self.id = id
        self.content = content
    }
    
    @MainActor
    public func open() {
        let image = ImageRenderer(content: content()).uiImage
        let prefix = "com.instagram.sharedSticker"
        let pasteboardItems: [String: Any] = [
            "\(prefix).stickerImage": image!.pngData()!,
            "\(prefix).backgroundTopColor": "#FFB707",
            "\(prefix).backgroundBottomColor": "#FFB707"
        ]
        let expireDate = Date().addingTimeInterval(300)
        let pasteboardOptions = [UIPasteboard.OptionsKey.expirationDate: expireDate]
        UIPasteboard.general.setItems([pasteboardItems], options: pasteboardOptions)
        let url = URL(string: "instagram-stories://share?source_application=\(id)")!
        UIApplication.shared.open(url)
    }
}
