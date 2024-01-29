//
//  ListBodyMeasurements.swift
//  GainTain
//
//  Created by fdisk on 1/1/24.
//

import CoreData
import SwiftUI

struct ListBodyMeasurements: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [
            NSSortDescriptor(keyPath: \BodyMeasurement.created_at, ascending: true)
        ],
        animation: .default)
    private var bodyMeasurements: FetchedResults<BodyMeasurement>
    @State var isActive = true
    @State private var navigationState: NavigationPath = .init()
    
    var body: some View {
        NavigationStack(path: $navigationState) {
            List {
                ForEach(bodyMeasurements) { bodyMeasurement in
                    NavigationLink(bodyMeasurement.date?.formatted() ?? "", value: bodyMeasurement)
                }
                .onDelete(perform: deleteBodyMeasurements)
            }
            .navigationDestination(for: BodyMeasurement.self) {  bodyMeasurement in
                EditBodyMeasurement(bodyMeasurement: bodyMeasurement, navigationState: $navigationState)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addBodyMeasurement) {
                        Label("Add Body Measurement", systemImage: "plus")
                    }
                }
            }
            Text("Select a body measurement")
        }
    }

    private func addBodyMeasurement() {
        withAnimation {
            let newBodyMeasurement = BodyMeasurement(context: viewContext)
            newBodyMeasurement.created_at = Date()

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

    private func deleteBodyMeasurements(offsets: IndexSet) {
        withAnimation {
            offsets.map { bodyMeasurements[$0] }.forEach(viewContext.delete)

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
}

#Preview {
    ListBodyMeasurements().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
