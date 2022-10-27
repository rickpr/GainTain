//
//  DoExercise.swift
//  GainTain
//
//  Created by fdisk on 10/26/22.
//

import SwiftUI

struct DoExercise: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var performed_exercise: PerformedExercise
    @FetchRequest var performed_sets: FetchedResults<PerformedSet>
    
    init(performed_exercise: PerformedExercise) {
        _performed_exercise = State(initialValue: performed_exercise)
        _performed_sets = DoExercise.get_performed_sets(
            performed_exercise: performed_exercise
        )
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(performed_sets) { performed_set in
                    NavigationLink {
                        DoSet(performed_set: performed_set)
                    } label: {
                        Text("\(performed_set.set?.reps ?? 0) reps")
                    }
                }
            }
        }
    }
 

    private static func get_performed_sets(
        performed_exercise: PerformedExercise
    ) -> FetchRequest<PerformedSet> {
        return FetchRequest<PerformedSet> (
            sortDescriptors: [
                NSSortDescriptor(
                    keyPath: \PerformedSet.created_at, ascending: true
                )
            ],
            predicate: NSPredicate(
                format: "performed_exercise == %@",
                performed_exercise
            ),
            animation: .default)
    }
}

struct DoExercise_Previews: PreviewProvider {
    static var previews: some View {
        DoExercise(performed_exercise: PerformedExercise())
    }
}
