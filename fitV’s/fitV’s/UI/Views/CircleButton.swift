//
//  CircleButton.swift
//  fitV’s
//
//  Created by Netanel Yerushalmi on 28/10/2021.
//

import UIKit

class CircleButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    func setupUI(){
        self.backgroundColor = kDefultButtonColor

        self.layer.cornerRadius = 0.5 * self.bounds.size.width
        
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 1
        
        self.setTitleColor(.black, for: .normal)
        self.titleLabel?.font = kDINAlternateBold?.withSize(36)
        
        self.clipsToBounds = true
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.heightAnchor.constraint(equalToConstant: 100).isActive = true
        self.widthAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
