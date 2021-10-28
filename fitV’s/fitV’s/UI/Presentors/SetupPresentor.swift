//
//  SetupPresentoer.swift
//  fitV’s
//
//  Created by Netanel Yerushalmi on 28/10/2021.
//

import UIKit

class SetupPresentor:SetupPresentorProtocol{
    
    private var currentCode = ""
    private var view:SetupViewProtocol
    
    required init(view: SetupViewProtocol) {
        self.view = view
        getWorkoutDetails()
    }
    
    @objc func circleWasPressed(sender:UIButton) {
        let generator = UIImpactFeedbackGenerator(style: .light)

        self.currentCode += sender.titleLabel?.text ?? ""
        generator.impactOccurred()
        
        self.view.buttonWasPressed(button: sender)
        
        if currentCode.count >= 4{
            chackCode()
            self.currentCode = ""
            self.view.resetCircles()
        }
    }
    
    private func chackCode(){
        var code = ""
        switch ExerciseData.state{
        case .Initial:
            code = ExerciseData.plan.setupSequence
        case .Inside:
            code = "\(ExerciseData.plan.reSetupSequence["inside"] ?? 0)"
        case .Between:
            code = "\(ExerciseData.plan.reSetupSequence["between"] ?? 0)"
        }
        
        if self.currentCode.lowercased() == code{
            self.view.goToActivity()
        }else{
            showPopup(massage: "Wrong Code")
        }
    }
    
    private func getWorkoutDetails(){
        self.view.addLoader()
        GetWorkoutDetails().getWorkoutDetails {
            self.view.removeLoader()
        } onFailure: { err in
            self.view.removeLoader()
            self.showPopup(massage: "Unable to get Workout Details")
        }
    }
    
    private func showPopup(massage: String){
        let alert = UIAlertController(title: "Error", message: massage, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(
            UIAlertAction(
                title: "OK",
                style: .default,
                handler: { _ in
                    DispatchQueue.main.async {
                        self.view.resetCircles()
                        
                    }
                }))
        
        DispatchQueue.main.async {
            self.view.showPopup(With: alert)
        }
    }
}
