//
//  FullWidthButton.swift
//  GainTain
//
//  Created by fdisk on 1/1/24.
//

import SwiftUI

struct FullWidthButton: View {
    let view: any View
    init(_ view: any View) { self.view = view }
    
    var body: some View {
        AnyView(view)
            .padding()
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .background(RoundedRectangle(cornerRadius: 16))
            .padding()
    }
    
}

#Preview {
    FullWidthButton(Text("Hello button!"))
}
