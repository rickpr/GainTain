//
//  EditCaliperMeasurement.swift
//  GainTain
//
//  Created by fdisk on 1/1/24.
//

import CoreData
import SwiftUI

struct EditCaliperMeasurement: View {
    @State private var caliperMeasurement: CaliperMeasurement
    @State private var caliper_measurement_abdominal_in_mm: Decimal?
    @State private var caliper_measurement_chest_in_mm: Decimal?
    @State private var caliper_measurement_midaxillary_in_mm: Decimal?
    @State private var caliper_measurement_subscapular_in_mm: Decimal?
    @State private var caliper_measurement_suprailiac_in_mm: Decimal?
    @State private var caliper_measurement_thigh_in_mm: Decimal?
    @State private var caliper_measurement_tricep_in_mm: Decimal?
    @Binding var navigationState: NavigationPath
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) var dismiss
    
    init(caliperMeasurement: CaliperMeasurement, navigationState: Binding<NavigationPath>) {
        _caliperMeasurement = State(initialValue: caliperMeasurement)
        _caliper_measurement_abdominal_in_mm = State(initialValue: caliperMeasurement.abdominal_in_mm as? Decimal)
        _caliper_measurement_chest_in_mm = State(initialValue: caliperMeasurement.chest_in_mm as? Decimal)
        _caliper_measurement_midaxillary_in_mm = State(initialValue: caliperMeasurement.midaxillary_in_mm as? Decimal)
        _caliper_measurement_subscapular_in_mm = State(initialValue: caliperMeasurement.subscapular_in_mm as? Decimal)
        _caliper_measurement_suprailiac_in_mm = State(initialValue: caliperMeasurement.suprailiac_in_mm as? Decimal)
        _caliper_measurement_thigh_in_mm = State(initialValue: caliperMeasurement.thigh_in_mm as? Decimal)
        _caliper_measurement_tricep_in_mm = State(initialValue: caliperMeasurement.tricep_in_mm as? Decimal)
        _navigationState = navigationState
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            NumberField(name: "Abdominal", value: $caliper_measurement_abdominal_in_mm)
            NumberField(name: "Chest", value: $caliper_measurement_chest_in_mm)
            NumberField(name: "Midaxillary", value: $caliper_measurement_midaxillary_in_mm)
            NumberField(name: "Subscapular", value: $caliper_measurement_subscapular_in_mm)
            NumberField(name: "Suprailiac", value: $caliper_measurement_suprailiac_in_mm)
            NumberField(name: "Thigh", value: $caliper_measurement_thigh_in_mm)
            NumberField(name: "Tricep", value: $caliper_measurement_tricep_in_mm)
            Spacer()
            HStack {
                Button(role: .destructive) {
                    navigationState = NavigationPath()
                } label: { Text("Cancel").padding() }
                Spacer()
                NavigationLink("Save", value: progressPhoto())
                    .navigationDestination(for: ProgressPhoto.self) { progressPhoto in
                        EditProgressPhoto(progressPhoto: progressPhoto, navigationState: $navigationState)
                    }.simultaneousGesture(TapGesture().onEnded { save_item() })
            }
        }
        .padding()
    }
    
    private func save_item() {
        withAnimation {
            caliperMeasurement.created_at = caliperMeasurement.created_at ?? Date()
            caliperMeasurement.abdominal_in_mm = caliper_measurement_abdominal_in_mm as? NSDecimalNumber
            caliperMeasurement.chest_in_mm = caliper_measurement_chest_in_mm as? NSDecimalNumber
            caliperMeasurement.midaxillary_in_mm = caliper_measurement_midaxillary_in_mm as? NSDecimalNumber
            caliperMeasurement.subscapular_in_mm = caliper_measurement_subscapular_in_mm as? NSDecimalNumber
            caliperMeasurement.suprailiac_in_mm = caliper_measurement_suprailiac_in_mm as? NSDecimalNumber
            caliperMeasurement.thigh_in_mm = caliper_measurement_thigh_in_mm as? NSDecimalNumber
            caliperMeasurement.tricep_in_mm = caliper_measurement_tricep_in_mm as? NSDecimalNumber
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    private func progressPhoto() -> ProgressPhoto {
        let progressPhoto = caliperMeasurement.body_measurement!.progress_photo ?? ProgressPhoto(context: viewContext)
        progressPhoto.body_measurement = caliperMeasurement.body_measurement!
        return progressPhoto
    }
}

#Preview {
    EditCaliperMeasurement(caliperMeasurement: CaliperMeasurement(), navigationState: .constant(NavigationPath()))
}
