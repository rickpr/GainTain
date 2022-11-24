//
//  EditWorkout.swift
//  GainTain
//
//  Created by fdisk on 10/26/22.
//
import SwiftUI

struct EditWorkout: View {
    @State private var workout: Workout
    @State private var workout_name: String
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) var dismiss
    
    init(workout: Workout) {
        _workout = State(initialValue: workout)
        _workout_name = State(initialValue: workout.name ?? "")
    }
    
    var body: some View {
        VStack {
            TextField(
                "Editing workout",
                text: $workout_name
            )
            .padding()
            
            Spacer()
            AddExercise(workout: workout)
            Spacer()
            
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
                .disabled(workout_name == "")
            }
        }
    }
    
    private func save_item() {
        withAnimation {
            workout.name = workout_name
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

struct EditWorkout_Previews: PreviewProvider {
    static var previews: some View {
        EditWorkout(workout: Workout())
    }
}
