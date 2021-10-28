//
//  SetupPresentorProtocol.swift
//  fitV’s
//
//  Created by Netanel Yerushalmi on 28/10/2021.
//

import UIKit

protocol SetupPresentorProtocol{
    init(view:SetupViewProtocol)
    func circleWasPressed(sender:UIButton)
}
