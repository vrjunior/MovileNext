//
//  StackViewController.swift
//  Next02
//
//  Created by Valmir Junior on 03/11/18.
//  Copyright © 2018 Valmir Junior. All rights reserved.
//

import UIKit

class StackViewController: UIViewController {
    
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var subStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func showHide(_ sender: Any) {
        UIView.animate(withDuration: 1.0) {
//            self.subStackView.isHidden = !self.subStackView.isHidden
//            self.topConstraint.constant = 120
//            self.view.layoutIfNeeded()
            if self.subStackView.axis == .vertical {
                self.subStackView.axis = .horizontal
            } else {
                self.subStackView.axis = .vertical
            }
        }
    }
    
}
