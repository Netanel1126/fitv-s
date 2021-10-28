//
//  SetupViewProtocol.swift
//  fitV’s
//
//  Created by Netanel Yerushalmi on 28/10/2021.
//

import UIKit

protocol SetupViewProtocol{
    func resetCircles()
    func goToActivity()
    func buttonWasPressed(button:UIButton)
    func showPopup(With popup:UIAlertController)
    func addLoader()
    func removeLoader()
}
