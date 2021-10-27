//
//  Consts.swift
//  fitV’s
//
//  Created by Netanel Yerushalmi on 27/10/2021.
//

import Foundation

var kPlan = ExercisePlan(fromJson: [:] )
var kTotelMeasrumentDone = 0
var kCompletedExercises = [Exercise]()
var kState:State = State(rawValue: UserDefaults.standard.integer(forKey: "state")) ?? State.Initial
