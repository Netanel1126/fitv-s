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
    
    init(fromJson:[String:Any]){
        name = fromJson["name"] as? String ?? ""
        startTime = fromJson["start_time"] as? Int ?? 0
        totalTime = fromJson["total_time"] as? Int ?? 0
    }
    
    func toJSON() -> [String:Any]{
        ["name":name, "total_time":totalTime]
    }
}
