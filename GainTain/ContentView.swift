//
//  ContentView.swift
//  GainTain
//
//  Created by fdisk on 10/26/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: ListWorkouts()) {
                    navButton(text: "Edit Workouts")
                }
                NavigationLink(destination: ListExercises()) {
                    navButton(text: "Edit Exercises")
                }
                NavigationLink(destination: PerformWorkout()) {
                    navButton(text: "Do a workout!")
                }
                NavigationLink(destination: ListBodyMeasurements()) {
                    navButton(text: "Track Progress")
                }
            }
        }
    }
    
    private func navButton(text: String) -> some View {
        FullWidthButton(
            HStack {
                Text(text)
                Image(systemName: "arrow.right")
            }
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
