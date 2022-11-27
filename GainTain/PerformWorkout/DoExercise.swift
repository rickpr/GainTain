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
        ScrollView(.vertical) {
            VStack(alignment: .center) {
                Text(performed_exercise.exercise?.name ?? "")
                    .padding()
                    .foregroundColor(Color(uiColor: .systemBackground))
                    .frame(maxWidth: .infinity)
                    .background(Color(uiColor: .systemBackground).colorInvert())
                ExerciseNotes(performed_exercise: performed_exercise)
                Divider()
                HStack {
                    VStack(alignment: .leading) {
                        Text("Sets")
                        HStack {
                            Text("\(performed_sets.count) sets,")
                            let rep_counts = performed_sets.map {
                                String($0.set?.min_reps ?? 0)
                            }
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
                    Button(action: addPerformedSet) {
                        HStack {
                            Image(systemName: "plus.circle")
                            Text("Add Set")
                        }
                        .padding()
                        .foregroundColor(.white)
                        .background(RoundedRectangle(cornerRadius: 16))
                    }
                }
                Divider()
                ForEach(performed_sets) { performed_set in
                    DoSet(performed_set: performed_set)
                }
            }
            .padding()
            RestTimer()
        }
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
            animation: .default
        )
    }
        
    private func addPerformedSet() {
        withAnimation {
            let last_performed_set_order = performed_sets.last?.ordering ?? 0
            let newPerformedSet = PerformedSet(context: viewContext)
            newPerformedSet.performed_exercise = performed_exercise
            newPerformedSet.created_at = Date()
            newPerformedSet.updated_at = Date()
            newPerformedSet.ordering = last_performed_set_order + 1
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
    
    private static func formatReps(performed_sets: [PerformedSet]) -> String {
        let rep_counts = performed_sets.map {
            let min_reps = $0.set?.min_reps
            let max_reps = $0.set?.max_reps
            if max_reps != nil && min_reps != nil && max_reps! > min_reps! {
                return "\(min_reps!)-\(max_reps!)"
            }
            return String(min_reps ?? 0)
        }
        if Dictionary(grouping: rep_counts, by: { $0 }).count > 1 {
            return "\(rep_counts.joined(separator: ", ")) reps"
        }
        return "\(rep_counts[0]) reps"
    }
}

struct DoExercise_Previews: PreviewProvider {
    static var previews: some View {
        DoExercise(performed_exercise: PerformedExercise())
    }
}
