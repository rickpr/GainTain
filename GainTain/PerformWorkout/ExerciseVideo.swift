//
//  ExerciseVideo.swift
//  GainTain
//
//  Created by fdisk on 11/9/22.
//

import SwiftUI


struct ExerciseVideo: View {
    private var exercise: Exercise
    
    init(exercise: Exercise) {
        self.exercise = exercise
    }
    
    var body: some View {
        WebView(url: URL(string: exercise.video_link!)!)
    }
}

struct ExerciseVideo_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseVideo(exercise: Exercise())
    }
}

