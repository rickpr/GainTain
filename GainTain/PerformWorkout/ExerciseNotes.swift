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
        let thumbnailLink = self.thumbnailLink()
        let content = HStack {
            if thumbnailLink != nil {
                AsyncImage(
                    url: URL(string: thumbnailLink!),
                    content: { image in
                        image.resizable().aspectRatio(contentMode: .fit)
                    },
                    placeholder: { ProgressView() }
                )
            }
            Text(performed_exercise.exercise?.notes ?? "")
                .foregroundColor(Color(uiColor: .secondaryLabel))
                .padding()
        }
        if thumbnailLink == nil {
            return AnyView(content)
        } else {
            return AnyView(NavigationLink(
                destination: ExerciseVideo(exercise: performed_exercise.exercise!)
            ) {
                content
            })
        }
    }
    
    private func thumbnailLink() -> String? {
        guard let videoLink = self.performed_exercise.exercise?.video_link else {
            return nil
        }
            
        var videoId: String? = nil
        if videoLink.contains("youtube") && videoLink.contains("=") {
            videoId = videoLink.components(separatedBy: "=").last
        }
        if videoLink.contains("youtu.be") {
            videoId = videoLink.components(separatedBy: "/").last
        }
        if videoId != nil {
            return "https://i3.ytimg.com/vi/\(videoId!)/0.jpg"
        }
        return nil
    }
}

struct ExerciseNotes_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseNotes(performed_exercise: PerformedExercise())
    }
}
