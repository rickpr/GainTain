//
//  DoWorkout.swift
//  GainTain
//
//  Created by fdisk on 10/26/22.
//

import SwiftUI
import CoreData

class CurrentPerformedExcerciseIndex: ObservableObject {
    @Published var performed_exercise_index: Int = 0
    
    func update(new_exercise_index: Int) {
        performed_exercise_index = new_exercise_index
    }
}

struct DoWorkout: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var performed_workout: PerformedWorkout
    @FetchRequest var performed_exercises: FetchedResults<PerformedExercise>
    @StateObject private var current_performed_exercise_index: CurrentPerformedExcerciseIndex = CurrentPerformedExcerciseIndex()
    
    init(performed_workout: PerformedWorkout) {
        _performed_workout = State(initialValue: performed_workout)
        _performed_exercises = DoWorkout.get_performed_exercises(
            performed_workout: performed_workout
        )
        
    }
    
    var body: some View {
        VStack {
            PerformedExerciseSelector(
                performed_exercises: performed_exercises,
                current_performed_exercise_index: current_performed_exercise_index
            )
            if !performed_exercises.isEmpty {
                DoExercise(
                    performed_exercise: performed_exercises[
                        current_performed_exercise_index.performed_exercise_index
                    ]
                ).padding()
                
            }
            Spacer()
        }.navigationBarTitle(performed_workout.workout?.name ?? "Today's Workout")
    }
    
    private static func get_performed_exercises(
        performed_workout: PerformedWorkout
    ) -> FetchRequest<PerformedExercise> {
        return FetchRequest<PerformedExercise> (
            sortDescriptors: [
                NSSortDescriptor(
                    keyPath: \PerformedExercise.ordering, ascending: true
                )
            ],
            predicate: NSPredicate(
                format: "performed_workout == %@",
                performed_workout
            ),
            animation: .default)
    }
}

struct DoWorkout_Previews: PreviewProvider {
    static var previews: some View {
        DoWorkout(performed_workout: PerformedWorkout())
    }
}
