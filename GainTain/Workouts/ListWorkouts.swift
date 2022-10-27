//  ContentView.swift
//  GainTain
//
//  Created by fdisk on 10/26/22.
//

import SwiftUI
import CoreData

struct ListWorkouts: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Workout.created_at, ascending: true)
        ],
        animation: .default)
    private var workouts: FetchedResults<Workout>

    var body: some View {
        NavigationView {
            List {
                ForEach(workouts) { workout in
                    NavigationLink {
                        EditWorkout(workout: workout)
                    } label: {
                        Text(workout.name ?? "")
                    }
                }
                .onDelete(perform: deleteWorkouts)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addWorkout) {
                        Label("Add Workout", systemImage: "plus")
                    }
                }
            }
            Text("Select a workout")
        }
    }

    private func addWorkout() {
        withAnimation {
            let newWorkout = Workout(context: viewContext)
            newWorkout.name = "Untitled Workout"
            newWorkout.created_at = Date()
            newWorkout.updated_at = Date()

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

    private func deleteWorkouts(offsets: IndexSet) {
        withAnimation {
            offsets.map { workouts[$0] }.forEach(viewContext.delete)

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

struct ListWorkouts_Previews: PreviewProvider {
    static var previews: some View {
        ListWorkouts().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
