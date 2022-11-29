//
//  GainTainTests.swift
//  GainTainTests
//
//  Created by fdisk on 10/26/22.
//

import XCTest
import CoreData
@testable import GainTain

final class GainTainTests: XCTestCase {
    private var context: NSManagedObjectContext? = nil
    override func setUp() {
        super.setUp()
        context = PersistenceController(inMemory: true).container.viewContext
    }

    override func tearDown() {
        context = nil
        super.tearDown()
    }
   
    func testFormatRepsMinAndMaxWithDifferences() throws {
        let set_one = Set(context: context!)
        let set_two = Set(context: context!)
        let performed_set_one = PerformedSet(context: context!)
        let performed_set_two = PerformedSet(context: context!)
        performed_set_one.set = set_one
        performed_set_two.set = set_two
        set_one.min_reps = 6
        set_one.max_reps = 8
        set_two.min_reps = 4
        set_two.max_reps = 6
        let formatted = DoExercise.formatReps(
            performed_sets: [performed_set_one, performed_set_two]
        )
        XCTAssert(formatted == "6-8, 4-6 reps", formatted)
    }
    
    func testFormatRepsWithSameMinAndMax() throws {
        let set_one = Set(context: context!)
        let set_two = Set(context: context!)
        let performed_set_one = PerformedSet(context: context!)
        let performed_set_two = PerformedSet(context: context!)
        performed_set_one.set = set_one
        performed_set_two.set = set_two
        set_one.min_reps = 6
        set_one.max_reps = 8
        set_two.min_reps = 6
        set_two.max_reps = 8
        let formatted = DoExercise.formatReps(
            performed_sets: [performed_set_one, performed_set_two]
        )
        XCTAssert(formatted == "6-8 reps", formatted)
    }
    
    func testFormatRepsWithOnlyMin() throws {
        let set_one = Set(context: context!)
        let set_two = Set(context: context!)
        let performed_set_one = PerformedSet(context: context!)
        let performed_set_two = PerformedSet(context: context!)
        performed_set_one.set = set_one
        performed_set_two.set = set_two
        set_one.min_reps = 6
        set_two.min_reps = 4
        let formatted = DoExercise.formatReps(
            performed_sets: [performed_set_one, performed_set_two]
        )
        XCTAssert(formatted == "6, 4 reps", formatted)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
