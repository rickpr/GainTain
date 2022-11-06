//
//  PerformedExerciseCircle.swift
//  GainTain
//
//  Created by fdisk on 11/6/22.
//

import SwiftUI

struct PerformedExerciseCircle: View {
    private var performed_exercise: PerformedExercise
    private var active : Bool
    private var number: Int
    
    init(performed_exercise: PerformedExercise, active: Bool, number: Int) {
        self.performed_exercise = performed_exercise
        self.active = active
        self.number = number
    }
    
    var body: some View {
        VStack {
            ZStack {
                Circle().fill(.foreground)
                Text(String(number))
                    .foregroundColor(Color(uiColor: .label))
            }
            .frame(width: 40, height: 40)
            RoundedRectangle(cornerRadius: 1)
                .fill(active ? Color(uiColor: .link) : Color(uiColor: .systemBackground))
                .frame(width: 40, height: 5)
        }
    }
}

struct PerformedExerciseCircle_Previews: PreviewProvider {
    static var previews: some View {
        PerformedExerciseCircle(performed_exercise: PerformedExercise(), active: true, number: 1)
    }
}
