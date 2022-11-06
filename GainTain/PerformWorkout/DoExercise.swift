//
//  DoExercise.swift
//  GainTain
//
//  Created by fdisk on 10/26/22.
//

import SwiftUI

struct DoExercise: View {
    @Environment(\.managedObjectContext) private var viewContext
    private var performed_exercise: PerformedExercise
    @FetchRequest var performed_sets: FetchedResults<PerformedSet>
    
    init(performed_exercise: PerformedExercise) {
        self.performed_exercise = performed_exercise
        _performed_sets = DoExercise.get_performed_sets(
            performed_exercise: performed_exercise
        )
    }
    
    var body: some View {
        VStack(alignment: .center) {
            Text(performed_exercise.exercise?.name ?? "")
                .padding(5)
                .background(Rectangle().fill(Color(uiColor: .systemBackground)).colorInvert())
                .foregroundColor(Color(uiColor: .systemBackground))
            Text(performed_exercise.exercise?.notes ?? "")
                .foregroundColor(Color(uiColor: .secondaryLabel))
                .padding()
            Divider()
            HStack {
                VStack(alignment: .leading) {
                    Text("Sets")
                    HStack {
                        Text("\(performed_sets.count) sets,")
                        let rep_counts = performed_sets.map { String($0.reps) }
                        if Dictionary(grouping: rep_counts, by: { $0 }).count > 1 {
                            Text("\(rep_counts.joined(separator: ", ")) reps")
                        } else {
                            Text("\(rep_counts[0]) reps")
                        }
                    }
                    .foregroundColor(Color(uiColor: .secondaryLabel))
                }
                .padding()
                Spacer()
            }
            Divider()
            ForEach(performed_sets) { performed_set in
                DoSet(performed_set: performed_set)
            }
        }
        .padding()
    }
 

    private static func get_performed_sets(
        performed_exercise: PerformedExercise
    ) -> FetchRequest<PerformedSet> {
        return FetchRequest<PerformedSet> (
            sortDescriptors: [
                NSSortDescriptor(
                    keyPath: \PerformedSet.ordering, ascending: true
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
