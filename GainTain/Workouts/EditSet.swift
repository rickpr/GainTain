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
    @State private var min_reps: Int16
    @State private var max_reps: Int16
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) var dismiss
    
    init(set: Set) {
        _set = State(initialValue: set)
        _min_reps = State(initialValue: set.min_reps)
        _max_reps = State(initialValue: set.max_reps)
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
                .disabled(min_reps <= 0 || min_reps >= max_reps)
            }
            
        }
        Spacer()
        TextField(
            "Minimum reps to do",
            value: $min_reps,
            format: .number
        )
        .padding()
        TextField(
            "Maximum reps to do (optional)",
            value: $max_reps,
            format: .number
        )
        .padding()
    }
    
    private func save_item() {
        withAnimation {
            set.min_reps = min_reps
            set.max_reps = max_reps
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
