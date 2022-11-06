//
//  ListExercises.swift
//  GainTain
//
//  Created by fdisk on 10/26/22.
//

import SwiftUI
import CoreData

struct ListExercises: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Exercise.created_at, ascending: true)
        ],
        animation: .default)
    private var exercises: FetchedResults<Exercise>

    var body: some View {
        List {
            ForEach(exercises) { exercise in
                NavigationLink {
                    EditExercise(exercise: exercise)
                } label: {
                    Text(exercise.name ?? "")
                }
            }
            .onDelete(perform: deleteExercises)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
            }
            ToolbarItem {
                Button(action: addExercise) {
                    Label("Add Exercise", systemImage: "plus")
                }
            }
        }
        Text("Select an exercise")
    }

    private func addExercise() {
        withAnimation {
            let newExercise = Exercise(context: viewContext)
            newExercise.name = "Untitled Exercise"
            newExercise.created_at = Date()
            newExercise.updated_at = Date()

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

    private func deleteExercises(offsets: IndexSet) {
        withAnimation {
            offsets.map { exercises[$0] }.forEach(viewContext.delete)

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
}

struct ListExercises_Previews: PreviewProvider {
    static var previews: some View {
        ListExercises().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
