//
//  SummaryViewController.swift
//  fitV’s
//
//  Created by Netanel Yerushalmi on 27/10/2021.
//

import UIKit

class SummaryViewController: UIViewController {

    private let meassageLable:UILabel = UILabel()
    private var presenter:SummaryPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = SummaryPresenter(view: self)
        setupUI()
    }
    
    private func setupUI(){
        self.view.backgroundColor = .white
        
        meassageLable.numberOfLines = 0
        meassageLable.textAlignment = .center
        meassageLable.font = kDINAlternateBold?.withSize(36)
        meassageLable.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(meassageLable)
        
        meassageLable.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        meassageLable.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        meassageLable.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10).isActive = true
    }
    
}

extension SummaryViewController:SummaryViewProtocol{
    
    func setMassageText(text: String) {
        self.meassageLable.text = text
    }
}
