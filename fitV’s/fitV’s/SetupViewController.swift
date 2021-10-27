//
//  SetupViewController.swift
//  fitV’s
//
//  Created by Netanel Yerushalmi on 27/10/2021.
//

import UIKit

class SetupViewController: UIViewController {

    var currentCode = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupUI()
    }
    
    func setupUI(){
        self.view.backgroundColor = .white
        let isInitial = kState == .Initial
        
    }
    
    func resetCircles(){
        
    }
    
    @objc func circleWasPressed(sender:UIButton){
        self.currentCode += sender.titleLabel?.text ?? ""
        if currentCode.count == 4{
            chackCode()
        }
    }
    
    func chackCode(){
        var currectCode = ""
        switch kState{
        case .Initial:
            currectCode = kPlan.setupSequence
        case .Inside:
            currectCode = "\(kPlan.reSetupSequence["inside"] ?? 0)"
        case .Between:
            currectCode = "\(kPlan.reSetupSequence["between"] ?? 0)"
        }
        
        if currectCode == currectCode{
            goToActivity()
        }else{
            showPopup()
        }
    }
    
    func goToActivity(){
        let vc = ActivityViewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    func showPopup(){
        let alert = UIAlertController(title: "Error", message: "Wrong Code", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            DispatchQueue.main.async {
                self.resetCircles()
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
