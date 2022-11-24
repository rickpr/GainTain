//
//  AddExercise.swift
//  GainTain
//
//  Created by fdisk on 10/26/22.
//

import SwiftUI

struct AddExercise: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var workout: Workout
    @State private var selected_exercise: Exercise? = nil
    @FetchRequest(
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Exercise.created_at, ascending: true)
        ],
        animation: .default)
    private var exercises: FetchedResults<Exercise>
    @FetchRequest var exercise_workouts: FetchedResults<ExerciseWorkout>
    
    init(workout: Workout) {
        _workout = State(initialValue: workout)
        _exercise_workouts = AddExercise.get_exercise_workouts(workout: workout)
    }
    
    var body: some View {
        List {
            ForEach(exercise_workouts) { exercise_workout in
                NavigationLink {
                    EditExerciseWorkout(exercise_workout: exercise_workout)
                } label: {
                    Text(exercise_workout.exercise?.name ?? "")
                }
            }
            .onDelete(perform: deleteExerciseWorkouts)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
            }
            ToolbarItem {
                Menu("Add an Exercise") {
                    ForEach(exercises) { exercise in
                        Button(
                            exercise.name ?? "Untitled Exercise",
                            action: { addExerciseWorkout(exercise: exercise) }
                        )
                    }
                }
            }
        }
    }
    
    private func addExerciseWorkout(exercise: Exercise) {
        withAnimation {
            let newExerciseWorkout = ExerciseWorkout(context: viewContext)
            newExerciseWorkout.created_at = Date()
            newExerciseWorkout.updated_at = Date()
            newExerciseWorkout.workout = workout
            newExerciseWorkout.exercise = exercise
            let newSet = Set(context: viewContext)
            newSet.exercise_workout = newExerciseWorkout
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


    
    private func deleteExerciseWorkouts(offsets: IndexSet) {
        withAnimation {
            offsets.map { exercise_workouts[$0] }.forEach(viewContext.delete)

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

    
    static func get_exercise_workouts(
        workout: Workout
    ) -> FetchRequest<ExerciseWorkout> {
        return FetchRequest<ExerciseWorkout> (
            sortDescriptors: [
                NSSortDescriptor(
                    keyPath: \ExerciseWorkout.created_at, ascending: true
                )
            ],
            predicate: NSPredicate(format: "workout == %@", workout),
            animation: .default)
    }
   

}

struct AddExercise_Previews: PreviewProvider {
    static var previews: some View {
        AddExercise(workout: Workout())
    }
}
