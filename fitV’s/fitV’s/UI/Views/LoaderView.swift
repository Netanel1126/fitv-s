//
//  LoaderView.swift
//  fitV’s
//
//  Created by Netanel Yerushalmi on 28/10/2021.
//

import UIKit

class LoaderView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    func setupUI(){
        self.backgroundColor = .black.withAlphaComponent(0.3)
        
        let loader = UIActivityIndicatorView(style: .large)
        loader.startAnimating()
        loader.color = .white
        loader.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(loader)
        
        loader.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        loader.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }

}
