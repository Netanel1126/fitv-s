//
//  ActivityPresentor.swift
//  fitV’s
//
//  Created by Netanel Yerushalmi on 28/10/2021.
//

import UIKit

class ActivityPresentor: ActivityPresentorProtocol{
    
    private var timer:Timer?
    private let view:ActivityViewProtocol
    
    required init(view: ActivityViewProtocol) {
        self.view = view
        
        updateState()
        updateTimers()
        
        self.startTimer()
    }
    
    private var current:Exercise {
        if ExerciseData.plan.exercises.count ==  ExerciseData.completedExercises.count{
            return ExerciseData.plan.exercises.last!
        }
        return ExerciseData.plan.exercises[ExerciseData.completedExercises.count]
    }
    
    private func startTimer(){
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(handleTimer), userInfo: nil, repeats: true)
    }
    
    @objc func handleTimer(){
        ExerciseData.timePassed += 1
        updateState()
        updateTimers()
    }
    
    private func updateState(){
        switch ExerciseData.state {
        case .Initial:
            break
        case .Inside:
            if (ExerciseData.timePassed - current.startTime) >= current.totalTime{
                ExerciseData.state = .Between
                ExerciseData.completedExercises.append(current)
                if ExerciseData.plan.exercises.count == ExerciseData.completedExercises.count{
                    timer?.invalidate()
                    self.view.goToSummaryScreen()
                }else{
                    self.view.startRest()
                }
            }else{
                startExercise()
            }
        case .Between:
            if ExerciseData.timePassed >= current.startTime{
                ExerciseData.state = .Inside
                startExercise()
            }else{
                self.view.startRest()
            }
        }
    }
    
    private func updateTimers(){
        let totelSeconds = ExerciseData.plan.totalTime - ExerciseData.timePassed
        var seconds = 0

        if ExerciseData.state == State.Between{
            seconds = current.startTime - ExerciseData.timePassed
        }else if ExerciseData.state == State.Inside{
            seconds = current.totalTime - (ExerciseData.timePassed - current.startTime)
        }
            
        self.view.updateTimersUI(totleTime: timeFormatted(totelSeconds), currentTime: timeFormatted(seconds))
    }
    
    func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    private func startExercise(){
        let hideExercise = ExerciseData.completedExercises.count == ExerciseData.plan.exercises.count - 1
        self.view.startExercise(exerciseName: current.name, hideTimer: hideExercise)
    }

    
    @objc func pauseTimer(){
        timer?.invalidate()
        showPopup()
    }
    
    private func showPopup(){
        let alert = UIAlertController(title: "Pused", message: "What Wold You Like To Do?", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Finish", style: .default,handler: { _ in
            self.sendDataToServer()
            self.view.goToSummaryScreen()
        }))
        alert.addAction(UIAlertAction(title: "Resume", style: .default,handler: { _ in
            self.sendDataToServer()
            self.view.goToSetupScreen()
        }))
        self.view.showPopup(withAlert: alert)
    }
    
    private func sendDataToServer(){
        if ExerciseData.completedExercises.count == 0{
            return
        }
        PostWorkoutSummary().postWorkoutSummary {
            print("Data Was Seccefuly Send To server")
        } onFailure: { err in
            print(err)
        }
    }
}
