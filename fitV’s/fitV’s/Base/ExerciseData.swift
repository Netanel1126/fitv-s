//
//  ExerciseData.swift
//  fitV’s
//
//  Created by Netanel Yerushalmi on 28/10/2021.
//

import Foundation

struct ExerciseData{
    static var plan = ExercisePlan(fromJson: [:] )
    static var timePassed = 0
    static var completedExercises = [Exercise]()
    static var state:State = State.Initial
}
