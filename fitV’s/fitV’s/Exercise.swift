//
//  Exercise.swift
//  fitV’s
//
//  Created by Netanel Yerushalmi on 27/10/2021.
//

import Foundation

struct Exercise{
    let name: String
    let startTime: Int
    let totalTime: Int
    var isDone = false
    
    init(fromJson:[String:Any]){
        name = fromJson["name"] as? String ?? ""
        startTime = fromJson["start_time"] as? Int ?? 0
        totalTime = fromJson["total_time"] as? Int ?? 0
    }
    
    func toJSON() -> [String:Any]{
        [:]
    }
}


struct ExercisePlan{
    
    let totalTime: Int
    var exercises: [Exercise]
    let setupSequence: String
    var reSetupSequence:[String:Int]

    init( totalTime: Int,exercises: [Exercise],setupSequence: String, reSetupSequence:[String:Int]){
        self.totalTime = totalTime
        self.exercises = exercises
        self.setupSequence = setupSequence
        self.reSetupSequence = reSetupSequence
    }
    
    init(fromJson:[String:Any]){
        totalTime = fromJson["total_time"] as? Int ?? 0
        setupSequence = fromJson["setup_sequence"] as? String ?? ""
        exercises = [Exercise]()
        if let exercisesJson = fromJson["exercises"] as? [[String:Any]]{
            for json in exercisesJson{
                exercises.append(Exercise(fromJson: json))
            }
            exercises.sort{
                $0.startTime < $1.startTime
            }
        }
        
        reSetupSequence = [String:Int]()
        
        if let sequencesJson = fromJson["re_setup_sequence"] as? [[String:Any]]{
            for sequence in sequencesJson{
                let type = sequence["type"] as? String ?? ""
                let code = sequence["code"] as? Int ?? 0

                reSetupSequence[type] = code
            }
        }
    }
}
