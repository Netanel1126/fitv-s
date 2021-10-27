//
//  ActivityViewController.swift
//  fitV’s
//
//  Created by Netanel Yerushalmi on 27/10/2021.
//

import UIKit

class ActivityViewController: UIViewController {

    let totleTimer:UILabel = UILabel()
    let currentExercise:UILabel = UILabel()
    let curentTimer:UILabel = UILabel()
    
    var current:Exercise?
    var exersiseIndex = 0
    var time = 0
    var timer:Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
        current = kPlan.exercises[exersiseIndex]
        startTimer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupUI()
    }
    
    
    func setupUI(){
        self.view.backgroundColor = .black
        
    }
    
    @objc func handleTimer(){
        time += 1
        updateTimersUI()
        
        switch kState {
        case .Initial:
            break
        case .Inside:
            if time >= current?.totalTime ?? 0{
                kState = .Between
                kPlan.exercises[exersiseIndex].isDone = true
                kCompletedExercises.append(current!)
                exersiseIndex += 1
                current = kPlan.exercises[exersiseIndex]
                if kPlan.exercises.count == exersiseIndex{
                    goToSummaryScreen()
                }else{
                    startRest()
                }
            }
        case .Between:
            if time >= current?.startTime ?? 0{
                kState = .Inside
                startExercise()
            }
        }
        
    }

    func updateTimersUI(){
        DispatchQueue.main.async { [self] in
            let totelSeconds = kPlan.totalTime - time
            var seconds = 0

            if let current = current {
                if kState == State.Between && !curentTimer.isHidden{
                    seconds = time - current.startTime
                }else if kState == State.Inside{
                    seconds = current.totalTime - (current.startTime - time)
                }
            }
            
            totleTimer.text = "\(totelSeconds / 60):\(totelSeconds % 60)"
            curentTimer.text = "\(seconds / 60):\(seconds % 60)"
        }
    }
    
    func startExercise(){
        DispatchQueue.main.async { [self] in
            currentExercise.text = current?.name ?? ""
            curentTimer.isHidden = exersiseIndex == kPlan.exercises.count - 1
        }
    }
    
    func startRest(){
        DispatchQueue.main.async {
            self.currentExercise.text = "REST"
        }
    }

    func goToSummaryScreen(){
        //TODO send to server
        kTotelMeasrumentDone = self.exersiseIndex
        let vc = SummaryViewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    func goToSetupScreen(){
        //TODO send to server
        self.dismiss(animated: true, completion: nil)

    }
    
    @objc func pauseTimer(){
        timer?.invalidate()
        showPopup()
    }
    
    @objc func startTimer(){
        timer = Timer(timeInterval: 1, target: self, selector: #selector(handleTimer), userInfo: nil, repeats: true)
    }
    
    
    func showPopup(){
        let alert = UIAlertController(title: "Pused", message: "What Wold You Like To Do?", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Finish", style: .default,handler: { _ in
            self.goToSetupScreen()
        }))
        alert.addAction(UIAlertAction(title: "Resume", style: .default,handler: { _ in
            self.goToSetupScreen()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
}
