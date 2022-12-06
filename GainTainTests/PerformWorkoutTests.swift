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
        exercise_workout_two.sets = [Set(context: context!)]
        
        do { try context!.save() }
        catch { fatalError("Failed to save PerformedWorkout!") }
        XCTAssert(workout.exercise_workouts == [exercise_workout_one, exercise_workout_two])
        
        // Check that no PerformedWorkouts exist before running
        var performed_workouts = try context!.fetch(PerformedWorkout.fetchRequest())
        XCTAssert(performed_workouts.count == 0, String(performed_workouts.count))
        PerformWorkout.addPerformedWorkout(workout: workout)
        do { try context!.save() }
        catch { fatalError("Failed to save PerformedWorkout!") }
        
        performed_workouts = try context!.fetch(PerformedWorkout.fetchRequest())
        XCTAssert(performed_workouts.count == 1, String(performed_workouts.count))
        let performed_workout = performed_workouts.first!
        context!.refresh(performed_workout, mergeChanges: false)
        
        let performed_exercises = try context!.fetch(PerformedExercise.fetchRequest())
        XCTAssert(performed_exercises.count == 2, String(performed_exercises.count))
        XCTAssert(
            performed_workout.performed_exercises!.count == 2,
            String(performed_workout.performed_exercises!.count)
        )
        
        // Check that we find both the expected performed workouts
        var found_performed_workouts = 0
        for performedExercise in performed_workout.performed_exercises! {
            let performed_exercise = performedExercise as! PerformedExercise
            if performed_exercise.exercise == exercise_one {
                found_performed_workouts += 1
                XCTAssert(
                    performed_exercise.performed_sets!.count == 2,
                    String(performed_exercise.performed_sets!.count)
                )
            }
            if performed_exercise.exercise == exercise_two {
                found_performed_workouts += 1
                XCTAssert(
                    performed_exercise.performed_sets!.count == 1,
                    String(performed_exercise.performed_sets!.count)
                )
            }
        }
        XCTAssert(
            found_performed_workouts == 2,
            "Expected 2 workouts, found \(found_performed_workouts)."
        )
        
    }
}
    
