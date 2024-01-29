//
//  EditBodyMeasurement.swift
//  GainTain
//
//  Created by fdisk on 1/1/24.
//

import SwiftUI

struct EditBodyMeasurement: View {
    @State private var bodyMeasurement: BodyMeasurement
    @State private var body_measurement_date: Date
    @State private var body_measurement_body_fat_percentage: Decimal?
    @State private var body_measurement_weight_in_pounds: Decimal?
    @Binding var navigationState: NavigationPath
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) var dismiss
    
    init(bodyMeasurement: BodyMeasurement, navigationState: Binding<NavigationPath>) {
        _bodyMeasurement = State(initialValue: bodyMeasurement)
        _body_measurement_date = State(initialValue: bodyMeasurement.date ?? Date())
        _body_measurement_body_fat_percentage = State(initialValue: bodyMeasurement.body_fat_percentage as? Decimal)
        _body_measurement_weight_in_pounds = State(initialValue: bodyMeasurement.weight_in_pounds as? Decimal)
        _navigationState = navigationState
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Date:")
            DatePicker(
                "Date",
                selection: $body_measurement_date
            ).textFieldStyle(.roundedBorder)
            Text("Body Fat Percentage:")
            TextField(
                "Editing Body Fat Percentage",
                value: $body_measurement_body_fat_percentage,
                format: .number
            ).textFieldStyle(.roundedBorder)
            Text("Weight (lbs):")
            TextField(
                "Editing Weight",
                value: $body_measurement_weight_in_pounds,
                format: .number
            ).textFieldStyle(.roundedBorder)
                .padding()
            Spacer()
            HStack {
                Button(role: .destructive) { navigationState = NavigationPath() } label: { Text("Cancel").padding() }
                Spacer()
                NavigationLink("Save", value: caliperMeasurement())
                    .navigationDestination(for: CaliperMeasurement.self) { caliperMeasurement in
                        EditCaliperMeasurement(
                            caliperMeasurement: caliperMeasurement,
                            navigationState: $navigationState
                        )
                    }.simultaneousGesture(TapGesture().onEnded { save_item() })
            }
        }
        .padding()
    }
    
    private func save_item() {
        withAnimation {
            bodyMeasurement.date = body_measurement_date
            bodyMeasurement.body_fat_percentage = body_measurement_body_fat_percentage as? NSDecimalNumber
            bodyMeasurement.weight_in_pounds = body_measurement_weight_in_pounds as? NSDecimalNumber
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError(
                    "Unresolved error \(nsError), \(nsError.userInfo)"
                )
            }
        }
    }
    
    private func caliperMeasurement() -> CaliperMeasurement {
        let measurement = bodyMeasurement.caliper_measurement ?? CaliperMeasurement(context: viewContext)
        measurement.body_measurement = bodyMeasurement
        return measurement
    }
}

#Preview {
    EditBodyMeasurement(bodyMeasurement: BodyMeasurement(), navigationState: .constant(NavigationPath()))
}
