//
//  CameraView.swift
//  GainTain
//
//  Created by fdisk on 1/1/24.
//

import SwiftUI

struct CameraView: UIViewControllerRepresentable {
    let editingPhoto: EditingPhoto
    @Binding var showSheet: Bool
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.delegate = context.coordinator
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    func makeCoordinator() -> Coordinator { Coordinator(cameraView: self) }
    func hideSheet() { showSheet = false }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let cameraView: CameraView
        init(cameraView: CameraView) { self.cameraView = cameraView }
        
        func imagePickerController(
            _ picker: UIImagePickerController,
            didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]
        ) {
            let uiImage = info[.originalImage] as? UIImage
            cameraView.editingPhoto.data = uiImage?.pngData()
            cameraView.hideSheet()
        }
    }
}

#Preview { CameraView(editingPhoto: EditingPhoto(data: nil), showSheet: .constant(true)) }
