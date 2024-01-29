//
//  PhotoField.swift
//  GainTain
//
//  Created by fdisk on 1/12/24.
//

import SwiftUI

class EditingPhoto: ObservableObject {
    @Published var data: Data?
    
    init(data: Data?) { self.data = data }
    func uiImage() -> UIImage? { data == nil ? nil : UIImage(data: data!) }
}

struct PhotoField: View {
    let name: String
    @ObservedObject var editingPhoto: EditingPhoto
    @State var showTakePhotoSheet: Bool = false
    @State var showViewPhotoSheet: Bool = false

    var body: some View {
        HStack {
            if editingPhoto.uiImage() != nil {
                Button { showViewPhotoSheet = true } label: {
                    Image(uiImage: editingPhoto.uiImage()!)
                        .resizable()
                        .frame(width: 32.0, height: 32.0)
                        .aspectRatio(contentMode: .fit)
                }
            }
            Button { showTakePhotoSheet = true } label: { FullWidthButton(Text(name)) }
        }.sheet(isPresented: $showTakePhotoSheet) {
            CameraView(editingPhoto: editingPhoto, showSheet: $showTakePhotoSheet)
        }.sheet(isPresented: $showViewPhotoSheet) { ViewPhoto(photo: editingPhoto.uiImage()!) }
        
    }

}

#Preview {
    PhotoField(name: "Front", editingPhoto: EditingPhoto(data: nil))
}
