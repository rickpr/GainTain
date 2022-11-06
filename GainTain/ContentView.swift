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
                    HStack {
                        Text("Edit Workouts")
                        Image(systemName: "arrow.right")
                    }
                    .padding()
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .background(RoundedRectangle(cornerRadius: 16))
                    .padding()
                }
                NavigationLink(destination: ListExercises()) {
                    HStack {
                        Text("Edit Exercises")
                        Image(systemName: "arrow.right")
                    }
                    .padding()
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .background(RoundedRectangle(cornerRadius: 16))
                    .padding()
                }
                NavigationLink(destination: PerformWorkout()) {
                    HStack {
                        Text("Do a workout!")
                        Image(systemName: "arrow.right")
                    }
                    .padding()
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .background(RoundedRectangle(cornerRadius: 16))
                    .padding()
                }

            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
