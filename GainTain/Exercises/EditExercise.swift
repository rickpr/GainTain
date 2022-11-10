//
//  EditExercise.swift
//  GainTain
//
//  Created by fdisk on 10/26/22.
//

import SwiftUI
import CoreData

struct EditExercise: View {
    @State private var exercise: Exercise
    @State private var exercise_name: String
    @State private var exercise_notes: String
    @State private var exercise_video_link: String
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) var dismiss
    
    init(exercise: Exercise) {
        _exercise = State(initialValue: exercise)
        _exercise_name = State(initialValue: exercise.name ?? "")
        _exercise_notes = State(initialValue: exercise.notes ?? "")
        _exercise_video_link = State(initialValue: exercise.video_link ?? "")
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Name:")
            TextField(
                "Editing exercise name",
                text: $exercise_name
            ).textFieldStyle(.roundedBorder)
            Text("Notes:")
            TextEditor(text: $exercise_notes)
                .textFieldStyle(.roundedBorder)
                .border(Color(uiColor: .secondaryLabel))
            Text("Video Link:")
            TextField(
                "Editing video link",
                text: $exercise_video_link
            ).textFieldStyle(.roundedBorder)
            .padding()
            Spacer()
            HStack {
                Button(role: .destructive) {
                    dismiss()
                } label: {
                    Text("Cancel").padding()
                }
                Spacer()
                Button {
                    save_item()
                    dismiss()
                } label: {
                    Text("Save").padding()
                }
                .disabled(exercise_name == "")
            }
        }
        .padding()
    }
    
    private func save_item() {
        withAnimation {
            exercise.name = exercise_name
            exercise.notes = exercise_notes
            exercise.video_link = exercise_video_link
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError(
                    "Unresolved error \(nsError), \(nsError.userInfo)"
                )
            }
        }
    }
}

struct EditExercise_Previews: PreviewProvider {
    static var previews: some View {
        EditExercise(exercise: Exercise())
    }
}
