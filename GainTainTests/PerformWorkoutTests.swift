//
//  PerformWorkoutTests.swift
//  GainTainTests
//
//  Created by fdisk on 11/27/22.
//

import XCTest
import CoreData
@testable import GainTain

final class PerformWorkoutTests: XCTestCase {
    private var context: NSManagedObjectContext? = nil
    override func setUp() {
        super.setUp()
        context = PersistenceController(inMemory: true).container.viewContext
    }

    override func tearDown() {
        context = nil
        super.tearDown()
    }

    func testCreatingPerformedWorkout() throws {
        let workout = Workout(context: context!)
        let exercise_one = Exercise(context: context!)
        let exercise_workout_one = ExerciseWorkout(context: context!)
        let exercise_two = Exercise(context: context!)
        let exercise_workout_two = ExerciseWorkout(context: context!)
        
        exercise_workout_one.exercise = exercise_one
        exercise_workout_one.workout = workout
        exercise_workout_one.sets = [Set(context: context!), Set(context: context!)]
        exercise_workout_two.exercise = exercise_two
        exercise_workout_two.workout = workout
        exercise_workout_one.sets = [Set(context: context!)]
        do { try context!.save() }
        catch { fatalError("Failed to save PerformedWorkout!") }
        XCTAssert(workout.exercise_workouts == [exercise_workout_one, exercise_workout_two])
        
        let performed_workout = PerformWorkout.addPerformedWorkout(workout: workout)
        do { try context!.save() }
        catch { fatalError("Failed to save PerformedWorkout!") }
        context!.refresh(performed_workout, mergeChanges: false)
        
        let performed_exercises = try context!.fetch(PerformedWorkout.fetchRequest())
        XCTAssert(performed_exercises.count == 2, String(performed_exercises.count))
        return
        // XCTAssert(performed_workout.performed_exercises!.count == 2, String(performed_workout.performed_exercises!.count))
        for (index, performedExercise) in performed_workout.performed_exercises!.enumerated() {
            let performed_exercise = performedExercise as! PerformedExercise
            if index == 0 {
                XCTAssert(performed_exercise.exercise == exercise_one)
                XCTAssert(performed_exercise.performed_sets!.count == 2)
                
            } else {
                XCTAssert(performed_exercise.exercise == exercise_two)
                XCTAssert(performed_exercise.performed_sets!.count == 1)
            }
        }
    }
 
}
