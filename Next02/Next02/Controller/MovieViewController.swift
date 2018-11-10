//
//  MovieViewController.swift
//  Next02
//
//  Created by Valmir Junior on 03/11/18.
//  Copyright © 2018 Valmir Junior. All rights reserved.
//

import UIKit


class MovieViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
}

extension MovieViewController: UIGestureRecognizerDelegate { }
