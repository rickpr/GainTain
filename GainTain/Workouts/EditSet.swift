//
//  EditSet.swift
//  GainTain
//
//  Created by fdisk on 10/26/22.
//

import SwiftUI
import CoreData

struct EditSet: View {
    @State private var set: Set
    @State private var reps: Int16
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) var dismiss
    
    init(set: Set) {
        _set = State(initialValue: set)
        _reps = State(initialValue: set.reps)
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
            "Editing set",
            value: $reps,
            format: .number
        )
        .padding()
    }
    
    private func save_item() {
        withAnimation {
            set.reps = reps
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

struct EditSet_Previews: PreviewProvider {
    static var previews: some View {
        EditSet(set: Set())
    }
}
