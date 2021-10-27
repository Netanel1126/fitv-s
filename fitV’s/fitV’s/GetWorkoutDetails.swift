//
//  GetWorkoutDetails.swift
//  fitV’s
//
//  Created by Netanel Yerushalmi on 27/10/2021.
//

import UIKit

class GetWorkoutDetails: BaseServerRequest {
    
    override func getFullURL() -> String {
        "https://ios-interviews.dev.fitvdev.com/getWorkoutDetails"
    }
    
    func getWorkoutDetails(onSuccess:@escaping () -> Void,onFailure:@escaping (Error) -> Void){
        GET { res in
            kPlan = ExercisePlan(fromJson: res as [String : Any])
            onSuccess()
        } onFailure: { err in
            onFailure(err)
        }

    }
}
