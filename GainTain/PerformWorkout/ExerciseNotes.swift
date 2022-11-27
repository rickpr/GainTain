//
//  ExerciseNotes.swift
//  GainTain
//
//  Created by fdisk on 11/9/22.
//
// Shows exercise description and offers a link to the video.

import SwiftUI

struct ExerciseNotes: View {
    private var performed_exercise: PerformedExercise
    
    init(performed_exercise: PerformedExercise) {
        self.performed_exercise = performed_exercise
    }
    
    var body: some View {
        HStack {
            VStack {
                Text(performed_exercise.exercise?.name ?? "")
                    .fontWeight(.bold)
                Text(performed_exercise.exercise?.notes ?? "")
                    .foregroundColor(Color(uiColor: .secondaryLabel))
                    .padding()
            }
            if self.performed_exercise.exercise?.video_link != nil {
                NavigationLink(
                    destination: ExerciseVideo(exercise: performed_exercise.exercise!)
                ) {
                    Label("Video", systemImage: "play")
                }
            }
        }
    }
}

struct ExerciseNotes_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseNotes(performed_exercise: PerformedExercise())
    }
}
