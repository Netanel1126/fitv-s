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
    var presentor:ActivityPresentor?

    override func viewDidLoad() {
        super.viewDidLoad()
        presentor = ActivityPresentor(view: self)
        setupUI()
    }
    
    func setupUI(){
        self.view.backgroundColor = .black
        
        self.totleTimer.textColor = .white
        self.totleTimer.font = kDINAlternateBold?.withSize(24)
        self.totleTimer.textAlignment = .right
        self.totleTimer.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(totleTimer)
        
        self.totleTimer.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 30).isActive = true
        self.totleTimer.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30).isActive = true
        
        self.curentTimer.textColor = .white
        self.curentTimer.font = kDINAlternateBold?.withSize(64)
        self.curentTimer.textAlignment = .center
        self.curentTimer.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(curentTimer)
        
        self.curentTimer.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.curentTimer.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true

        self.currentExercise.textColor = .white
        self.currentExercise.font = kDINAlternateBold?.withSize(48)
        self.currentExercise.textAlignment = .center
        self.currentExercise.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(currentExercise)
        
        self.currentExercise.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.currentExercise.bottomAnchor.constraint(equalTo: self.curentTimer.topAnchor, constant: -50).isActive = true
        
        let pauseButton = UIButton(type: .custom)
        pauseButton.setTitleColor(.black, for: .normal)
        pauseButton.setTitle("Pause".uppercased(), for: .normal)
        pauseButton.titleLabel?.font = kDINAlternateBold?.withSize(24)
        pauseButton.backgroundColor = .white
        pauseButton.layer.cornerRadius = 20
        pauseButton.addTarget(self.presentor, action: #selector(self.presentor?.pauseTimer), for: .touchUpInside)
        pauseButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(pauseButton)
        
        pauseButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        pauseButton.topAnchor.constraint(equalTo: self.curentTimer.bottomAnchor, constant: 50).isActive = true
        pauseButton.widthAnchor.constraint(equalToConstant: 230).isActive = true
        pauseButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
    }
    
}

extension ActivityViewController:ActivityViewProtocol{
    
    func updateTimersUI(totleTime:String,currentTime:String){
        DispatchQueue.main.async { [self] in
            totleTimer.text = totleTime
            curentTimer.text = currentTime
        }
    }

    func startExercise(exerciseName:String, hideTimer:Bool) {
        DispatchQueue.main.async { [self] in
            currentExercise.text = exerciseName
            curentTimer.isHidden = hideTimer
        }
    }
    
    func startRest(){
        DispatchQueue.main.async {
            self.currentExercise.text = "REST"
        }
    }

    func goToSummaryScreen(){
        let vc = SummaryViewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    func goToSetupScreen(){
        self.dismiss(animated: true, completion: nil)
    }
    
    func showPopup(withAlert:UIAlertController){
        self.present(withAlert, animated: true, completion: nil)
    }
}
