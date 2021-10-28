//
//  PostWorkoutSummary.swift
//  fitV’s
//
//  Created by Netanel Yerushalmi on 27/10/2021.
//

import UIKit

class PostWorkoutSummary: BaseServerRequest {
    override func getFullURL() -> String {
        "https://ios-interviews.dev.fitvdev.com/addWorkoutSummary"
    }
    
    override func getParams() -> [String : Any] {
        let lestExercises = ExerciseData.completedExercises.last!
        var completedJson = [[String:Any]]()
    
        for completed in ExerciseData.completedExercises{
            completedJson.append(completed.toJSON())
        }
        
        return ["exercises_completed":completedJson, "total_time_completed":"\(lestExercises.startTime + lestExercises.totalTime)"]
    }
    
    func postWorkoutSummary(onSuccess:@escaping () -> Void,onFailure:@escaping (Error) -> Void){
        POST { res in
            onSuccess()
        } onFailure: { err in
            onFailure(err)
        }

    }
}
