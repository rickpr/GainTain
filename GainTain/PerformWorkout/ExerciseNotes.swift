//
//  ExerciseNotes.swift
//  GainTain
//
//  Created by fdisk on 11/9/22.
//

import SwiftUI

struct ExerciseNotes: View {
    private var performed_exercise: PerformedExercise
    
    init(performed_exercise: PerformedExercise) {
        self.performed_exercise = performed_exercise
    }
    
    var body: some View {
        let content = HStack {
            VStack {
                Text(performed_exercise.exercise?.name ?? "")
                    .fontWeight(.bold)
                Text(performed_exercise.exercise?.notes ?? "")
                    .foregroundColor(Color(uiColor: .secondaryLabel))
                    .padding()
            }
        }
        if self.performed_exercise.exercise?.video_link != nil {
            return AnyView(NavigationLink(
                destination: ExerciseVideo(exercise: performed_exercise.exercise!)
            ) {
                content
            })
        } else {
            return AnyView(content)
        }
    }
}

struct ExerciseNotes_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseNotes(performed_exercise: PerformedExercise())
    }
}
