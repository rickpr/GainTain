//
//  NumberField.swift
//  GainTain
//
//  Created by fdisk on 1/28/24.
//

import SwiftUI

struct NumberField: View {
    private let name: String
    @Binding var value: Decimal?
    
    init(name: String, value: Binding<Decimal?>) {
        self.name = name
        _value = value
    }
    
    var body: some View {
        Group {
            Text("\(name) (mm)")
            TextField(
                "Editing \(name)",
                value: $value,
                format: .number
            ).textFieldStyle(.roundedBorder)
        }
    }
}

#Preview {
    NumberField(name: "Bicep", value: .constant(0))
}
