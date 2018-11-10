//
//  ScrollViewController.swift
//  Next02
//
//  Created by Valmir Junior on 03/11/18.
//  Copyright © 2018 Valmir Junior. All rights reserved.
//

import UIKit

class ScrollViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Properties
    
    
    // MARK: - Super Methods
    
    
    // MARK: - Methods
    @objc func keyboardWillShow(notification: NSNotification) {
        
        guard let userInfo = notification.userInfo else { return }
        guard let height = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.size.height else { return }
        
        scrollView.contentInset.bottom = height
        scrollView.scrollIndicatorInsets.bottom = height
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        scrollView.contentInset.bottom = 0
        scrollView.scrollIndicatorInsets.bottom = 0
    }
    
    
    // MARK: - IBACtions
    
}
