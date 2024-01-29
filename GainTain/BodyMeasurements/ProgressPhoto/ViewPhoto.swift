//
//  ViewPhoto.swift
//  GainTain
//
//  Created by fdisk on 1/13/24.
//

import SwiftUI

struct ViewPhoto: View {
    let photo: UIImage
    var body: some View {
        Image(uiImage: photo).resizable().aspectRatio(contentMode: .fit)
    }
}

#Preview {
    ViewPhoto(photo: UIImage())
}
