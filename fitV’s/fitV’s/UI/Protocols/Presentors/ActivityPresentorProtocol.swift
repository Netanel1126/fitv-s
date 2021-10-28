//
//  ActivityPresentorProtocol.swift
//  fitV’s
//
//  Created by Netanel Yerushalmi on 28/10/2021.
//

import Foundation

protocol ActivityPresentorProtocol{
    
    init(view:ActivityViewProtocol)
    func pauseTimer()
}
