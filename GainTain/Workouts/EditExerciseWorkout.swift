//
//  EditExerciseWorkout.swift
//  GainTain
//
//  Created by fdisk on 10/26/22.
//

import SwiftUI

struct EditExerciseWorkout: View {
    @State private var exercise_workout: ExerciseWorkout
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest var sets: FetchedResults<Set>
    
    init(exercise_workout: ExerciseWorkout) {
        _exercise_workout = State(initialValue: exercise_workout)
        _sets = EditExerciseWorkout.get_sets(exercise_workout: exercise_workout)
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(sets) { set in
                    NavigationLink {
                        EditSet(set: set)
                    } label: {
                        Text("\(set.reps) reps")
                    }
                }
                .onDelete(perform: deleteSets)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addSet) {
                        Label("Add set", systemImage: "plus")
                    }
                }
            }
            Text("Select an exercise")
        }
    }
 
    private func addSet() {
        withAnimation {
            let newSet = Set(context: viewContext)
            newSet.created_at = Date()
            newSet.updated_at = Date()
            newSet.reps = 0
            newSet.exercise_workout = exercise_workout

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

    private func deleteSets(offsets: IndexSet) {
        withAnimation {
            offsets.map { sets[$0] }.forEach(viewContext.delete)

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

    private static func get_sets(
        exercise_workout: ExerciseWorkout
    ) -> FetchRequest<Set> {
        return FetchRequest<Set> (
            sortDescriptors: [
                NSSortDescriptor(
                    keyPath: \Set.created_at, ascending: true
                )
            ],
            predicate: NSPredicate(format: "exercise_workout == %@", exercise_workout),
            animation: .default)
    }
   

}

struct EditExerciseWorkout_Previews: PreviewProvider {
    static var previews: some View {
        EditExerciseWorkout(exercise_workout: ExerciseWorkout())
    }
}
