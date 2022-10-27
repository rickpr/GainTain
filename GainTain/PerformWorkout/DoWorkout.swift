//
//  DoWorkout.swift
//  GainTain
//
//  Created by fdisk on 10/26/22.
//

import SwiftUI
import CoreData

struct DoWorkout: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var performed_workout: PerformedWorkout
    @FetchRequest var performed_exercises: FetchedResults<PerformedExercise>
    
    init(performed_workout: PerformedWorkout) {
        _performed_workout = State(initialValue: performed_workout)
        _performed_exercises = DoWorkout.get_performed_exercises(
            performed_workout: performed_workout
        )
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(performed_exercises) { performed_exercise in
                    NavigationLink {
                        DoExercise(performed_exercise: performed_exercise)
                    } label: {
                        Text(performed_exercise.exercise?.name ?? "")
                    }
                }
            }
        }
    }
     
    private static func get_performed_exercises(
        performed_workout: PerformedWorkout
    ) -> FetchRequest<PerformedExercise> {
        return FetchRequest<PerformedExercise> (
            sortDescriptors: [
                NSSortDescriptor(
                    keyPath: \PerformedExercise.created_at, ascending: true
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
