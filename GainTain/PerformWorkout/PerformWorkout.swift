//
//  PerformWorkout.swift
//  GainTain
//
//  Created by fdisk on 10/26/22.
//

import SwiftUI
import CoreData

struct PerformWorkout: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var selected_workout: Workout? = nil
    @FetchRequest(
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Workout.created_at, ascending: true)
        ],
        animation: .default)
    private var workouts: FetchedResults<Workout>
    @FetchRequest var performed_workouts: FetchedResults<PerformedWorkout>
    
    init() {
        _performed_workouts = PerformWorkout.get_performed_workouts()
    }
    
    
    var body: some View {
        NavigationView {
            List {
                ForEach(performed_workouts) { performed_workout in
                    NavigationLink {
                        DoWorkout(performed_workout: performed_workout)
                    } label: {
                        Text(performed_workout.workout?.name ?? "")
                    }
                }
                .onDelete(perform: deletePerformedWorkouts)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Menu("Select a Workout") {
                        ForEach(workouts) { workout in
                            Button(
                                workout.name ?? "Untitled Workout",
                                action: { addPerformedWorkout(workout: workout) }
                            )
                        }
                    }
                }
            }
            Text("Select an exercise")
        }
    }
    
    private func addPerformedWorkout(workout: Workout) {
        withAnimation {
            let newPerformedWorkout = PerformedWorkout(context: viewContext)
            newPerformedWorkout.created_at = Date()
            newPerformedWorkout.updated_at = Date()
            newPerformedWorkout.workout = workout
            workout.exercise_workouts?.forEach { exercise_workout in
                let exerciseWorkout = exercise_workout as! ExerciseWorkout
                let newPerformedExercise = PerformedExercise(context: viewContext)
                newPerformedExercise.performed_workout = newPerformedWorkout
                newPerformedExercise.exercise = exerciseWorkout.exercise
                exerciseWorkout.sets?.forEach { set in
                    let newPerformedSet = PerformedSet(context: viewContext)
                    newPerformedSet.performed_exercise = newPerformedExercise
                    newPerformedSet.set = set as? Set
                }
            }
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

    private func deletePerformedWorkouts(offsets: IndexSet) {
        withAnimation {
            offsets.map { performed_workouts[$0] }.forEach(viewContext.delete)

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


    

    private static func get_performed_workouts() -> FetchRequest<PerformedWorkout> {
        return FetchRequest<PerformedWorkout> (
            sortDescriptors: [
                NSSortDescriptor(
                    keyPath: \PerformedWorkout.created_at, ascending: true
                )
            ],
            animation: .default)
    }
 
}

struct PerformWorkout_Previews: PreviewProvider {
    static var previews: some View {
        PerformWorkout()
    }
}