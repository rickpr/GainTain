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
    @State private var current_performed_exercise: PerformedExercise?
    
    init(performed_workout: PerformedWorkout) {
        _performed_workout = State(initialValue: performed_workout)
        _performed_exercises = DoWorkout.get_performed_exercises(
            performed_workout: performed_workout
        )
        
    }
    
    var body: some View {
        VStack {
            HStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        ForEach(
                            Array(performed_exercises.enumerated()),
                            id: \.offset
                        ) { index, performed_exercise in
                            Button(
                                action: {
                                    self.current_performed_exercise = performed_exercise
                                }
                            ) {
                                PerformedExerciseCircle(
                                    performed_exercise: performed_exercise,
                                    active: current_performed_exercise == performed_exercise,
                                    number: index + 1
                                )
                            }
                        }
                    }
                    .frame(minWidth: UIScreen.main.bounds.width)
                }
            }
        }
        .onAppear() {
            if !performed_exercises.isEmpty {
                self.current_performed_exercise = performed_exercises[0]
            }
        }
        if current_performed_exercise != nil {
            DoExercise(performed_exercise: current_performed_exercise!)
        }
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
