//
//  ActivityViewProtocol.swift
//  fitV’s
//
//  Created by Netanel Yerushalmi on 28/10/2021.
//

import UIKit

protocol ActivityViewProtocol{
    func startRest()
    func startExercise(exerciseName:String,hideTimer:Bool)
    func goToSummaryScreen()
    func goToSetupScreen()
    
    func updateTimersUI(totleTime:String,currentTime:String)
    func showPopup(withAlert:UIAlertController)
}
