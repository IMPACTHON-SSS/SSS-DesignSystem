import SwiftUI
import PhotosUI
import Camera_SwiftUI
import Combine
import AVFoundation

@available(iOS 16, macOS 13, *)
public struct CameraView: View {
    
    @Environment(\.dismiss) var dismiss
    @Binding var image: UIImage?
    
    private let service = CameraService()
    private var session: AVCaptureSession
    
    @State var isFlashOn = false
    @State var imageSelection: PhotosPickerItem?
    @State var subscriptions = [AnyCancellable]()
    
    public init(_ image: Binding<UIImage?>) {
        self._image = image
        self.session = service.session
    }
    
    func subscribe() {
        subscriptions = [
            service.$photo.sink { [self] (photo) in
                guard let pic = photo else { return }
                self.image = pic.image!
                dismiss()
            },
            service.$flashMode.sink { [self] (mode) in
                self.isFlashOn = mode == .on
            },
        ]
    }
    
    func loadTransferable(from imageSelection: PhotosPickerItem) {
        imageSelection.loadTransferable(type: Data.self) { result in
            DispatchQueue.main.async {
                guard imageSelection == self.imageSelection else { return }
                if case let .success(image) = result {
                    self.image = UIImage(data: image!)
                    dismiss()
                }
            }
        }
    }
    
    public var body: some View {
        VStack(spacing: 20) {
            Button {
                service.flashMode = service.flashMode == .on ? .off : .on
            } label: {
                var icon: Image {
                    isFlashOn ? .flash : .flashSlash
                }
                icon
                    .resizable()
                    .frame(width: 24, height: 24)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 16)
            CameraPreview(session: session)
                .aspectRatio(3/4, contentMode: .fit)
                .onAppear {
                    subscribe()
                    service.checkForPermissions()
                    service.configure()
                }
            ZStack(alignment: .leading) {
                Button(action: service.capturePhoto) {
                    Circle()
                        .foregroundColor(.whiteColor)
                        .frame(width: 80, height: 80, alignment: .center)
                        .overlay(
                            Circle()
                                .stroke(Color.blackColor.opacity(0.8), lineWidth: 2)
                                .frame(width: 65, height: 65)
                        )
                }
                .frame(maxWidth: .infinity)
                PhotosPicker(selection: $imageSelection,
                             matching: .images,
                             photoLibrary: .shared()) {
                    Image.mountain
                        .resizable()
                        .scaledToFit()
                        .frame(width: 22.4, height: 22.4)
                        .foregroundStyle(Color.whiteColor)
                        .padding(16.8)
                        .background(Color.blackColor)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                             .padding(.leading, 16)
                             .onChange(of: imageSelection) { newValue in
                                 if let newValue {
                                     loadTransferable(from: newValue)
                                 }
                             }
            }
        }
        .padding(.vertical, 20)
    }
}
