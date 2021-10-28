//
//  SummaryPresenter.swift
//  fitV’s
//
//  Created by Netanel Yerushalmi on 28/10/2021.
//

import Foundation

class SummaryPresenter:SummaryPresenterProtocol{
    let view:SummaryViewProtocol
    
    required init(view: SummaryViewProtocol) {
        self.view = view
        setupMassage()
    }
    
    private func setupMassage(){
        let totelPresentge = (ExerciseData.completedExercises.count / ExerciseData.plan.exercises.count) * 100
        var msg = ""

        if totelPresentge > 60{
            msg = "Champion, it’s too easy for you!"
        }else if totelPresentge > 30{
            msg = "Well done, you nailed it!"
        }else{
            msg = "Not bad, try harder next time!"
        }
        
        self.view.setMassageText(text: msg)
    }
}
