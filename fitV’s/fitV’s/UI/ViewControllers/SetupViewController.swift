//
//  SetupViewController.swift
//  fitV’s
//
//  Created by Netanel Yerushalmi on 27/10/2021.
//

import UIKit

class SetupViewController: UIViewController {

    private var buttons = [UIButton]()
    private var presentor:SetupPresentor?
    private var loader:LoaderView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presentor = SetupPresentor(view: self)
        self.setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.updateUI()
    }
        
    private func setupUI(){
        self.view.backgroundColor = .white
        
        let vStack = UIStackView()
        vStack.axis = .vertical
        vStack.distribution = .fillEqually
        vStack.spacing = 10
        vStack.translatesAutoresizingMaskIntoConstraints = false
        
        vStack.addArrangedSubview(createStackRow())
        vStack.addArrangedSubview(createStackRow())
        self.view.addSubview(vStack)

        vStack.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        vStack.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        if let loader = self.loader {
            self.view.bringSubviewToFront(loader)
        }
    }
    
    private func updateUI(){
        let isInitial = ExerciseData.state == .Initial
        
        for i in 0..<self.buttons.count{
            let text = isInitial ? String(format: "%c", i+65) : "\(i + 1)"
            self.buttons[i].setTitle(text, for: .normal)
        }
    }
    
    private func createStackRow() -> UIStackView {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 10
        stack.distribution = .fillEqually

        for _ in 0..<3{
            stack.addArrangedSubview(createCircleButton())
        }
        
        return stack
    }
    
    private func createCircleButton() -> CircleButton{
        let button = CircleButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        button.addTarget(self.presentor, action: #selector(presentor?.circleWasPressed(sender:)), for: .touchUpInside)
        
        self.buttons.append(button)
        return button
    }
}

extension SetupViewController:SetupViewProtocol{
    func buttonWasPressed(button: UIButton) {
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = kSelectedButtonColor
    }
    
    func showPopup(With popup: UIAlertController) {
        self.present(popup, animated: true, completion: nil)
    }
    
    func resetCircles(){
        for button in buttons {
            button.setTitleColor(.black, for: .normal)
            button.backgroundColor = kDefultButtonColor
        }
    }
    
    func goToActivity(){
        let vc = ActivityViewController()

        if ExerciseData.state == .Initial{
            ExerciseData.state = .Between
        }
        
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    func addLoader() {
        self.loader = LoaderView(frame: self.view.bounds)
        self.view.addSubview(loader!)
    }
    
    func removeLoader() {
        DispatchQueue.main.async {
            self.loader?.removeFromSuperview()
        }
    }
}
