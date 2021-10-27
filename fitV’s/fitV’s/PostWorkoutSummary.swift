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
        let lestExercises = kCompletedExercises.last!
        var completedJson = [[String:Any]]()
        var params = ["total_time_completed":"\(lestExercises.startTime + lestExercises.totalTime)"]
    
        for completed in kCompletedExercises{
            completedJson.append(completed)
        }
        
        return params
    }
}
