//
//  SummaryViewController.swift
//  fitV’s
//
//  Created by Netanel Yerushalmi on 27/10/2021.
//

import UIKit

class SummaryViewController: UIViewController {

    private let meassageLable:UILabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupUI()
        updateUI()
    }
    
    func setupUI(){
        
    }
    
    func updateUI(){
        let totelPresentge = kTotelMeasrumentDone / kPlan.exercises.count * 100
        var msg = ""

        if totelPresentge > 60{
            msg = "Champion, it’s too easy for you!"
        }else if totelPresentge > 30{
            msg = "Well done, you nailed it!"
        }else{
            msg = "Not bad, try harder next time!"
        }
        
        self.meassageLable.text = msg
    }
    
}
