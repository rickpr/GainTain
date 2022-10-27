//
//  DoSet.swift
//  GainTain
//
//  Created by fdisk on 10/26/22.
//

import SwiftUI

struct DoSet: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) var dismiss
    @State private var performed_set: PerformedSet
    @State private var reps: Int16
    @State private var weight: Float

    init(performed_set: PerformedSet) {
        _performed_set = State(initialValue: performed_set)
        _reps = State(initialValue: performed_set.reps)
        _weight = State(initialValue: performed_set.weight)
    }

    var body: some View {
        VStack {
            HStack {
                Button(role: .destructive) {
                    dismiss()
                } label: {
                    Text("Cancel").padding()
                }
                Spacer()
                Button {
                    save_item()
                    dismiss()
                } label: {
                    Text("Save").padding()
                }
                .disabled(reps <= 0)
            }
            
        }
        Spacer()
        TextField(
            "Editing reps",
            value: $reps,
            format: .number
        )
        .padding()
        Spacer()
        TextField(
            "Editing weight",
            value: $weight,
            format: .number
        )
        .padding()
    }
    
    private func save_item() {
        withAnimation {
            performed_set.reps = reps
            performed_set.weight = weight
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

}

struct DoSet_Previews: PreviewProvider {
    static var previews: some View {
        DoSet(performed_set: PerformedSet())
    }
}
