//
//  PerformedExerciseSelector.swift
//  GainTain
//
//  Created by fdisk on 12/6/22.
//

import SwiftUI

struct PerformedExerciseSelector: View {
    private var performed_exercises: FetchedResults<PerformedExercise>
    private var current_performed_exercise_index: CurrentPerformedExcerciseIndex
    
    init(
        performed_exercises: FetchedResults<PerformedExercise>,
        current_performed_exercise_index: CurrentPerformedExcerciseIndex
    ) {
        self.performed_exercises = performed_exercises
        self.current_performed_exercise_index = current_performed_exercise_index
    }
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 0) {
                ForEach(self.prepare_performed_exercises(), id: \.index) { performed_exercise in
                    Button(
                        action: {
                            self.current_performed_exercise_index.update(
                                new_exercise_index: performed_exercise.index
                            )
                        }
                    ) {
                        VStack {
                            ZStack {
                                RoundedRectangle(cornerRadius: 2).fill(performed_exercise.foreground_color)
                                Text(String(performed_exercise.index + 1))
                                    .foregroundColor(performed_exercise.text_color)
                            }
                            .frame(width: 40, height: 40)
                        }
                    }
                    if !performed_exercise.is_superset {
                        Spacer().frame(width: 8)
                    }
                }
            }
            .frame(minWidth: UIScreen.main.bounds.width)
        }
    }
    
    private struct PerformedExerciseInfo {
        let index: Int
        let active: Bool
        let is_superset: Bool
        let foreground_color: Color
        let text_color: Color
    }
    
    private func prepare_performed_exercises() -> [PerformedExerciseInfo] {
        return performed_exercises.enumerated().map { index, performed_exercise in
            let active = current_performed_exercise_index.performed_exercise_index == index
            return PerformedExerciseInfo(
                index: index,
                active: active,
                is_superset: performed_exercise.superset_with_next_exercise,
                foreground_color: Color(active ? .label : .tertiaryLabel),
                text_color: Color(active ? .systemBackground : .label)
            )
        }
    }
}

/* TODO: Make this work.
struct PerformedExerciseSelector_Previews: PreviewProvider {
    static var previews: some View {
        PerformedExerciseSelector(
            performed_exercises: [] as FetchedResults<PerformedExercise>,
            current_performed_exercise_index: CurrentPerformedExcerciseIndex()
        )
    }
}
*/
